-- BUKU INDUK SISWA SDN JANGKONG
-- Jalankan di Supabase SQL Editor. Aktifkan Email/Password di Authentication.
create table if not exists public.students (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  nisn text,
  nipd text,
  class_name text not null default 'Kelas 1',
  gender text check (gender in ('L','P')),
  status text not null default 'Aktif',
  data jsonb not null default '{}'::jsonb,
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists students_name_idx on public.students using gin (to_tsvector('simple', coalesce(name,'')));
create index if not exists students_class_idx on public.students(class_name);
create index if not exists students_nisn_idx on public.students(nisn);
alter table public.students enable row level security;
-- Hanya pengguna yang sudah login dapat membaca dan mengelola data.
drop policy if exists "Authenticated users can read students" on public.students;
create policy "Authenticated users can read students" on public.students for select to authenticated using (true);
drop policy if exists "Authenticated users can insert students" on public.students;
create policy "Authenticated users can insert students" on public.students for insert to authenticated with check (true);
drop policy if exists "Authenticated users can update students" on public.students;
create policy "Authenticated users can update students" on public.students for update to authenticated using (true) with check (true);
drop policy if exists "Authenticated users can delete students" on public.students;
create policy "Authenticated users can delete students" on public.students for delete to authenticated using (true);
-- Profil sekolah sederhana untuk semua pengguna login.
create table if not exists public.school_settings (key text primary key, value text not null);
alter table public.school_settings enable row level security;
drop policy if exists "Authenticated users manage school settings" on public.school_settings;
create policy "Authenticated users manage school settings" on public.school_settings for all to authenticated using (true) with check (true);
insert into public.school_settings(key,value) values
 ('school_name','SDN JANGKONG'),('npsn','20529470'),('address','Jangkong, Batang-Batang, Sumenep, Jawa Timur'),('school_year','2026/2027')
on conflict(key) do nothing;


-- Arsip kelulusan: siswa tetap tersimpan pada tabel yang sama.
alter table public.students add column if not exists graduation_year integer;
create index if not exists students_graduation_year_idx on public.students(graduation_year) where status = 'Lulus';
