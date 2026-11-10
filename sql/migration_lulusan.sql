-- Jalankan SATU KALI di Supabase > SQL Editor > New query.
-- Menambahkan kolom tahun lulus tanpa menghapus atau memindahkan data siswa.
alter table public.students
  add column if not exists graduation_year integer;

create index if not exists students_graduation_year_idx
  on public.students (graduation_year)
  where status = 'Lulus';
