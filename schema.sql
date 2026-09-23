-- ... existing code ...
-- 4. Pastikan Tabel incomes (Pemasukan) Ada & Lengkap
CREATE TABLE IF NOT EXISTS public.incomes (
    id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
    user_id TEXT,
    author_name TEXT,
    author_role TEXT,
    income_type TEXT,
    type TEXT,
    amount NUMERIC(15,2) NOT NULL DEFAULT 0,
    transaction_date DATE DEFAULT CURRENT_DATE,
    date DATE DEFAULT CURRENT_DATE,
    notes TEXT,
    photo_url TEXT,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);
-- STREAMING_CHUNK:Adding category columns to incomes table for complete compatibility...
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS user_id TEXT;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS author_name TEXT;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS author_role TEXT;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS category_id TEXT;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS category_name TEXT;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS income_type TEXT;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS type TEXT;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS transaction_date DATE DEFAULT CURRENT_DATE;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS date DATE DEFAULT CURRENT_DATE;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS notes TEXT;
ALTER TABLE public.incomes ADD COLUMN IF NOT EXISTS photo_url TEXT;

-- 5. Pastikan Tabel expenses (Pengeluaran) Ada & Lengkap
-- ... existing code ...
