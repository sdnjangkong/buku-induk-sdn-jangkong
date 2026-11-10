-- Aktifkan pencarian siswa publik dengan kolom terbatas.
-- Jalankan seluruh skrip ini di Supabase SQL Editor.
-- View ini hanya membuka nama, NISN, tahun masuk, dan tahun lulus.
create or replace view public.student_public_lookup
with (security_barrier = true)
as
select
  name,
  nisn,
  case
    when (data->>'enrollment_date') ~ '^[0-9]{4}'
      then substring(data->>'enrollment_date' from 1 for 4)
    else null
  end as enrollment_year,
  graduation_year
from public.students;

revoke all on public.student_public_lookup from public;
grant select on public.student_public_lookup to anon, authenticated;
