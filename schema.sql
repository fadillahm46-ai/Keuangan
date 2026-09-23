-- 1. Aktifkan ekstensi generator UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 2. Buat tabel profiles
CREATE TABLE IF NOT EXISTS public.profiles (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    full_name TEXT NOT NULL,
    role TEXT CHECK (role IN ('Suami', 'Istri', 'Anak')) DEFAULT 'Suami',
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL DEFAULT '123',
    avatar_url TEXT DEFAULT 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=160&h=160&fit=crop',
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Buat tabel master kategori
CREATE TABLE IF NOT EXISTS public.categories_master (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    name TEXT UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT true NOT NULL,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 4. Buat tabel incomes
CREATE TABLE IF NOT EXISTS public.incomes (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    user_id TEXT REFERENCES public.profiles(id) ON DELETE SET NULL,
    author_name TEXT NOT NULL,
    author_role TEXT NOT NULL,
    income_type TEXT CHECK (income_type IN ('gaji', 'non_gaji', 'tarik_tabungan')) NOT NULL,
    amount NUMERIC(15,2) NOT NULL CHECK (amount > 0),
    transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
    notes TEXT,
    photo_url TEXT,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 5. Buat tabel expenses
CREATE TABLE IF NOT EXISTS public.expenses (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    user_id TEXT REFERENCES public.profiles(id) ON DELETE SET NULL,
    author_name TEXT NOT NULL,
    author_role TEXT NOT NULL,
    category_id TEXT REFERENCES public.categories_master(id) ON DELETE SET NULL,
    category_name TEXT NOT NULL,
    amount NUMERIC(15,2) NOT NULL CHECK (amount > 0),
    transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,
    notes TEXT,
    photo_url TEXT,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 6. Buat tabel savings_history
CREATE TABLE IF NOT EXISTS public.savings_history (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    period_month TEXT NOT NULL,
    amount_saved NUMERIC(15,2) NOT NULL,
    notes TEXT,
    is_deduction BOOLEAN DEFAULT false NOT NULL,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 7. Aktifkan Row Level Security (RLS)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories_master ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.incomes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.savings_history ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public read-write for profiles" ON public.profiles;
CREATE POLICY "Allow public read-write for profiles" ON public.profiles FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public read-write for categories_master" ON public.categories_master;
CREATE POLICY "Allow public read-write for categories_master" ON public.categories_master FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public read-write for incomes" ON public.incomes;
CREATE POLICY "Allow public read-write for incomes" ON public.incomes FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public read-write for expenses" ON public.expenses;
CREATE POLICY "Allow public read-write for expenses" ON public.expenses FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow public read-write for savings_history" ON public.savings_history;
CREATE POLICY "Allow public read-write for savings_history" ON public.savings_history FOR ALL USING (true) WITH CHECK (true);

-- 8. Tambahkan ke replikasi Realtime
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'supabase_realtime') THEN
        IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'incomes') THEN
            ALTER PUBLICATION supabase_realtime ADD TABLE public.incomes;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'expenses') THEN
            ALTER PUBLICATION supabase_realtime ADD TABLE public.expenses;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'savings_history') THEN
            ALTER PUBLICATION supabase_realtime ADD TABLE public.savings_history;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'profiles') THEN
            ALTER PUBLICATION supabase_realtime ADD TABLE public.profiles;
        END IF;
    END IF;
END $$;
