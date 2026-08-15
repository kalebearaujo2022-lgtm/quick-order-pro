
revoke execute on function public.has_role(uuid, public.app_role) from public, anon;
revoke execute on function public.owns_restaurant(uuid) from public, anon;
grant execute on function public.has_role(uuid, public.app_role) to authenticated;
grant execute on function public.owns_restaurant(uuid) to authenticated;
