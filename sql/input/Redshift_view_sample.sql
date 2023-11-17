-- https://docs.aws.amazon.com/redshift/latest/dg/r_CREATE_VIEW.html
create view sales_vw as
select * from public.sales
union all
select * from spectrum.sales
with no schema binding;
