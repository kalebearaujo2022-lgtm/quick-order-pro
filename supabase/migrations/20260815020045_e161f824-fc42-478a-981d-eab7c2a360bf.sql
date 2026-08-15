
insert into public.products (id, restaurant_id, category_id, name, name_en, description, description_en, price, promo_price, image_url, ingredients, is_featured, is_promo, sold_count, rating) values
('a1000000-0000-0000-0000-000000000001','11111111-1111-1111-1111-111111111111',(select id from public.categories where slug='hamburgueres'),'Burger Clássico','Classic Burger','Blend 180g, alface, tomate, queijo e molho da casa no pão brioche.','180g beef blend, lettuce, tomato, cheese and house sauce on a brioche bun.',25.00,null,'/images/burger-classic.jpg','{"Blend 180g","Alface","Tomate","Queijo","Molho da casa","Pão brioche"}',true,false,342,4.8),
('a1000000-0000-0000-0000-000000000002','11111111-1111-1111-1111-111111111111',(select id from public.categories where slug='hamburgueres'),'Bacon Supreme','Bacon Supreme','Dois blends, cheddar duplo e bacon crocante.','Double blend, double cheddar and crispy bacon.',32.90,null,'/images/burger-bacon.jpg','{"Blend 180g x2","Cheddar","Bacon","Pão brioche"}',true,false,517,4.9),
('a1000000-0000-0000-0000-000000000003','11111111-1111-1111-1111-111111111111',(select id from public.categories where slug='hamburgueres'),'Cheddar Duplo','Double Cheddar','Muito cheddar cremoso, cebola caramelizada e blend suculento.','Loads of creamy cheddar, caramelized onion and juicy blend.',34.90,29.90,'/images/hero-burger.jpg','{"Blend 180g x2","Cheddar cremoso","Cebola caramelizada"}',false,true,289,4.7),
('a1000000-0000-0000-0000-000000000004','11111111-1111-1111-1111-111111111111',(select id from public.categories where slug='pizzas'),'Pizza Pepperoni','Pepperoni Pizza','Massa artesanal, molho de tomate italiano e pepperoni fatiado.','Artisanal dough, italian tomato sauce and sliced pepperoni.',49.90,null,'/images/pizza-pepperoni.jpg','{"Massa artesanal","Molho de tomate","Mussarela","Pepperoni"}',true,false,410,4.8),
('a1000000-0000-0000-0000-000000000005','11111111-1111-1111-1111-111111111111',(select id from public.categories where slug='pizzas'),'Pizza Margherita','Margherita Pizza','Mussarela de búfala, tomate e manjericão fresco.','Buffalo mozzarella, tomato and fresh basil.',44.90,null,'/images/pizza-margherita.jpg','{"Massa artesanal","Mussarela de búfala","Tomate","Manjericão"}',false,false,233,4.6),
('a1000000-0000-0000-0000-000000000006','11111111-1111-1111-1111-111111111111',(select id from public.categories where slug='combos'),'Combo Casal','Couple Combo','2 burgers + batata grande + 2 bebidas.','2 burgers + large fries + 2 drinks.',79.90,69.90,'/images/combo.jpg','{"2 Burgers","Batata grande","2 Bebidas"}',true,true,198,4.9),
('a1000000-0000-0000-0000-000000000007','11111111-1111-1111-1111-111111111111',(select id from public.categories where slug='porcoes'),'Batata Cheddar','Cheddar Fries','Batata crocante com cheddar cremoso e bacon.','Crispy fries with creamy cheddar and bacon.',18.90,null,'/images/fries.jpg','{"Batata","Cheddar","Bacon"}',false,false,376,4.7),
('a1000000-0000-0000-0000-000000000008','11111111-1111-1111-1111-111111111111',(select id from public.categories where slug='bebidas'),'Refrigerante 350ml','Soda 350ml','Lata gelada 350ml.','Cold 350ml can.',8.00,null,'/images/drink.jpg','{"Refrigerante"}',false,false,620,4.5);

do $$
declare p uuid; g_bread uuid; g_cheese uuid; g_extra uuid;
begin
  foreach p in array array['a1000000-0000-0000-0000-000000000001'::uuid,'a1000000-0000-0000-0000-000000000002'::uuid,'a1000000-0000-0000-0000-000000000003'::uuid]
  loop
    insert into public.option_groups (product_id, name, name_en, min_select, max_select, sort_order) values (p,'Escolha o pão','Choose your bun',1,1,1) returning id into g_bread;
    insert into public.addons (product_id, group_id, name, name_en, price, sort_order) values
      (p,g_bread,'Tradicional','Traditional',0,1),
      (p,g_bread,'Brioche','Brioche',2.00,2),
      (p,g_bread,'Integral','Whole wheat',2.00,3);

    insert into public.option_groups (product_id, name, name_en, min_select, max_select, sort_order) values (p,'Escolha o queijo','Choose your cheese',1,1,2) returning id into g_cheese;
    insert into public.addons (product_id, group_id, name, name_en, price, sort_order) values
      (p,g_cheese,'Cheddar','Cheddar',4.00,1),
      (p,g_cheese,'Mussarela','Mozzarella',3.00,2),
      (p,g_cheese,'Prato','Prato cheese',3.00,3);

    insert into public.option_groups (product_id, name, name_en, min_select, max_select, sort_order) values (p,'Adicionais','Extras',0,6,3) returning id into g_extra;
    insert into public.addons (product_id, group_id, name, name_en, price, sort_order) values
      (p,g_extra,'Bacon','Bacon',5.00,1),
      (p,g_extra,'Cebola caramelizada','Caramelized onion',3.00,2),
      (p,g_extra,'Ovo','Egg',3.00,3),
      (p,g_extra,'Molho especial','Special sauce',2.00,4),
      (p,g_extra,'Batata','Fries',8.00,5),
      (p,g_extra,'Bebida','Drink',8.00,6);
  end loop;
end $$;

insert into public.coupons (restaurant_id, code, discount_type, value, usage_limit, is_active) values
('11111111-1111-1111-1111-111111111111','BEMVINDO10','percent',10,1000,true),
('11111111-1111-1111-1111-111111111111','FRETEGRATIS','freeship',0,1000,true);
