
-- ROLES
create type public.app_role as enum ('admin','owner','customer');

create table public.user_roles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  role app_role not null,
  created_at timestamptz not null default now(),
  unique (user_id, role)
);
grant select on public.user_roles to authenticated;
grant all on public.user_roles to service_role;
alter table public.user_roles enable row level security;

create or replace function public.has_role(_user_id uuid, _role app_role)
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.user_roles where user_id = _user_id and role = _role)
$$;

create policy "users read own roles" on public.user_roles for select to authenticated using (auth.uid() = user_id);

-- PROFILES
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  email text,
  phone text,
  address text,
  address_number text,
  complement text,
  neighborhood text,
  city text,
  zip_code text,
  reference_point text,
  points integer not null default 0,
  preferences jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
grant select, insert, update, delete on public.profiles to authenticated;
grant all on public.profiles to service_role;
alter table public.profiles enable row level security;
create policy "profiles own select" on public.profiles for select to authenticated using (auth.uid() = id);
create policy "profiles own insert" on public.profiles for insert to authenticated with check (auth.uid() = id);
create policy "profiles own update" on public.profiles for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

create or replace function public.update_updated_at_column()
returns trigger language plpgsql set search_path = public as $$
begin new.updated_at = now(); return new; end; $$;

create trigger profiles_updated_at before update on public.profiles
for each row execute function public.update_updated_at_column();

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, full_name, email)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name'), new.email)
  on conflict (id) do nothing;
  insert into public.user_roles (user_id, role) values (new.id, 'customer') on conflict do nothing;
  return new;
end; $$;

create trigger on_auth_user_created after insert on auth.users
for each row execute function public.handle_new_user();

-- RESTAURANTS
create table public.restaurants (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid references auth.users(id) on delete set null,
  slug text unique not null,
  name text not null,
  logo_url text,
  cover_url text,
  description text,
  address text,
  phone text,
  whatsapp text,
  opening_hours text,
  delivery_fee numeric(10,2) not null default 0,
  estimated_time text default '30-45 min',
  is_open boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
grant select on public.restaurants to anon;
grant select, insert, update, delete on public.restaurants to authenticated;
grant all on public.restaurants to service_role;
alter table public.restaurants enable row level security;
create policy "restaurants public read" on public.restaurants for select using (true);
create policy "restaurants owner insert" on public.restaurants for insert to authenticated with check (auth.uid() = owner_id);
create policy "restaurants owner update" on public.restaurants for update to authenticated using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
create policy "restaurants owner delete" on public.restaurants for delete to authenticated using (auth.uid() = owner_id);
create trigger restaurants_updated_at before update on public.restaurants for each row execute function public.update_updated_at_column();

create or replace function public.owns_restaurant(_restaurant_id uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.restaurants r where r.id = _restaurant_id and r.owner_id = auth.uid())
$$;

-- CATEGORIES
create table public.categories (
  id uuid primary key default gen_random_uuid(),
  restaurant_id uuid not null references public.restaurants(id) on delete cascade,
  name text not null,
  name_en text,
  slug text not null,
  icon text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
grant select on public.categories to anon;
grant select, insert, update, delete on public.categories to authenticated;
grant all on public.categories to service_role;
alter table public.categories enable row level security;
create policy "categories public read" on public.categories for select using (true);
create policy "categories owner all" on public.categories for all to authenticated using (public.owns_restaurant(restaurant_id)) with check (public.owns_restaurant(restaurant_id));

-- PRODUCTS
create table public.products (
  id uuid primary key default gen_random_uuid(),
  restaurant_id uuid not null references public.restaurants(id) on delete cascade,
  category_id uuid references public.categories(id) on delete set null,
  name text not null,
  name_en text,
  description text,
  description_en text,
  price numeric(10,2) not null default 0,
  promo_price numeric(10,2),
  image_url text,
  ingredients text[] not null default '{}',
  is_active boolean not null default true,
  is_featured boolean not null default false,
  is_promo boolean not null default false,
  sold_count integer not null default 0,
  rating numeric(3,2) not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
grant select on public.products to anon;
grant select, insert, update, delete on public.products to authenticated;
grant all on public.products to service_role;
alter table public.products enable row level security;
create policy "products public read" on public.products for select using (true);
create policy "products owner all" on public.products for all to authenticated using (public.owns_restaurant(restaurant_id)) with check (public.owns_restaurant(restaurant_id));
create trigger products_updated_at before update on public.products for each row execute function public.update_updated_at_column();

-- OPTION GROUPS + ADDONS
create table public.option_groups (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id) on delete cascade,
  name text not null,
  name_en text,
  min_select integer not null default 0,
  max_select integer not null default 1,
  sort_order integer not null default 0
);
grant select on public.option_groups to anon;
grant select, insert, update, delete on public.option_groups to authenticated;
grant all on public.option_groups to service_role;
alter table public.option_groups enable row level security;
create policy "option_groups public read" on public.option_groups for select using (true);

create table public.addons (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references public.products(id) on delete cascade,
  group_id uuid references public.option_groups(id) on delete cascade,
  name text not null,
  name_en text,
  description text,
  price numeric(10,2) not null default 0,
  is_active boolean not null default true,
  sort_order integer not null default 0
);
grant select on public.addons to anon;
grant select, insert, update, delete on public.addons to authenticated;
grant all on public.addons to service_role;
alter table public.addons enable row level security;
create policy "addons public read" on public.addons for select using (true);

-- COUPONS
create table public.coupons (
  id uuid primary key default gen_random_uuid(),
  restaurant_id uuid references public.restaurants(id) on delete cascade,
  user_id uuid references auth.users(id) on delete cascade,
  code text not null,
  discount_type text not null default 'percent',
  value numeric(10,2) not null default 0,
  expires_at timestamptz,
  usage_limit integer not null default 1,
  used_count integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique (code)
);
grant select on public.coupons to anon;
grant select, insert, update, delete on public.coupons to authenticated;
grant all on public.coupons to service_role;
alter table public.coupons enable row level security;
create policy "coupons public read" on public.coupons for select using (user_id is null);
create policy "coupons own read" on public.coupons for select to authenticated using (auth.uid() = user_id);
create policy "coupons own insert" on public.coupons for insert to authenticated with check (auth.uid() = user_id);
create policy "coupons own update" on public.coupons for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- ORDERS
create table public.orders (
  id uuid primary key default gen_random_uuid(),
  order_number serial,
  customer_id uuid not null references auth.users(id) on delete cascade,
  restaurant_id uuid not null references public.restaurants(id) on delete cascade,
  status text not null default 'received',
  fulfillment text not null default 'delivery',
  payment_method text not null default 'pix',
  change_for numeric(10,2),
  subtotal numeric(10,2) not null default 0,
  discount numeric(10,2) not null default 0,
  delivery_fee numeric(10,2) not null default 0,
  total numeric(10,2) not null default 0,
  coupon_code text,
  notes text,
  address text,
  address_number text,
  complement text,
  neighborhood text,
  city text,
  zip_code text,
  reference_point text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
grant select, insert, update on public.orders to authenticated;
grant all on public.orders to service_role;
alter table public.orders enable row level security;
create policy "orders customer read" on public.orders for select to authenticated using (auth.uid() = customer_id);
create policy "orders customer insert" on public.orders for insert to authenticated with check (auth.uid() = customer_id);
create policy "orders restaurant read" on public.orders for select to authenticated using (public.owns_restaurant(restaurant_id));
create policy "orders restaurant update" on public.orders for update to authenticated using (public.owns_restaurant(restaurant_id)) with check (public.owns_restaurant(restaurant_id));
create trigger orders_updated_at before update on public.orders for each row execute function public.update_updated_at_column();

create table public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  product_id uuid references public.products(id) on delete set null,
  product_name text not null,
  image_url text,
  unit_price numeric(10,2) not null default 0,
  quantity integer not null default 1,
  addons jsonb not null default '[]'::jsonb,
  removed_ingredients text[] not null default '{}',
  notes text,
  line_total numeric(10,2) not null default 0
);
grant select, insert on public.order_items to authenticated;
grant all on public.order_items to service_role;
alter table public.order_items enable row level security;
create policy "order_items read" on public.order_items for select to authenticated using (
  exists (select 1 from public.orders o where o.id = order_id and (o.customer_id = auth.uid() or public.owns_restaurant(o.restaurant_id)))
);
create policy "order_items insert" on public.order_items for insert to authenticated with check (
  exists (select 1 from public.orders o where o.id = order_id and o.customer_id = auth.uid())
);

-- REVIEWS
create table public.reviews (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  restaurant_id uuid not null references public.restaurants(id) on delete cascade,
  order_id uuid references public.orders(id) on delete set null,
  author_name text,
  rating integer not null default 5,
  comment text,
  photo_url text,
  created_at timestamptz not null default now()
);
grant select on public.reviews to anon;
grant select, insert, update, delete on public.reviews to authenticated;
grant all on public.reviews to service_role;
alter table public.reviews enable row level security;
create policy "reviews public read" on public.reviews for select using (true);
create policy "reviews own insert" on public.reviews for insert to authenticated with check (auth.uid() = user_id);
create policy "reviews own update" on public.reviews for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "reviews own delete" on public.reviews for delete to authenticated using (auth.uid() = user_id);

-- FAVORITES
create table public.favorites (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  product_id uuid not null references public.products(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (user_id, product_id)
);
grant select, insert, delete on public.favorites to authenticated;
grant all on public.favorites to service_role;
alter table public.favorites enable row level security;
create policy "favorites own all" on public.favorites for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- REWARDS / ROULETTE
create table public.rewards (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  prize text not null,
  points integer not null default 0,
  coupon_id uuid references public.coupons(id) on delete set null,
  status text not null default 'active',
  created_at timestamptz not null default now()
);
grant select, insert, update on public.rewards to authenticated;
grant all on public.rewards to service_role;
alter table public.rewards enable row level security;
create policy "rewards own all" on public.rewards for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- INVOICES
create table public.invoices (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  number text,
  status text not null default 'pending',
  provider text,
  document_url text,
  amount numeric(10,2) not null default 0,
  created_at timestamptz not null default now()
);
grant select on public.invoices to authenticated;
grant all on public.invoices to service_role;
alter table public.invoices enable row level security;
create policy "invoices own read" on public.invoices for select to authenticated using (auth.uid() = user_id);

-- NOTIFICATIONS
create table public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  body text,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);
grant select, insert, update, delete on public.notifications to authenticated;
grant all on public.notifications to service_role;
alter table public.notifications enable row level security;
create policy "notifications own all" on public.notifications for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

alter publication supabase_realtime add table public.orders;

-- DEMO RESTAURANT
insert into public.restaurants (id, slug, name, description, address, phone, whatsapp, opening_hours, delivery_fee, estimated_time, is_open)
values ('11111111-1111-1111-1111-111111111111','burger-house','Burger House','Hambúrgueres artesanais, pizzas na pedra e combos para compartilhar.','Rua das Palmeiras, 450 - Centro','+556899239 0173','5568992390173','Seg a Dom, 18h às 23h30', 7.90, '30-45 min', true);

insert into public.categories (restaurant_id, name, name_en, slug, sort_order) values
('11111111-1111-1111-1111-111111111111','Hambúrgueres','Burgers','hamburgueres',1),
('11111111-1111-1111-1111-111111111111','Pizzas','Pizzas','pizzas',2),
('11111111-1111-1111-1111-111111111111','Combos','Combos','combos',3),
('11111111-1111-1111-1111-111111111111','Porções','Sides','porcoes',4),
('11111111-1111-1111-1111-111111111111','Bebidas','Drinks','bebidas',5),
('11111111-1111-1111-1111-111111111111','Sobremesas','Desserts','sobremesas',6);
