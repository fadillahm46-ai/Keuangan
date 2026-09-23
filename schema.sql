<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
  <meta name="theme-color" content="#071328">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
  <title>KEUANGAN KELUARGA - Realtime & Collaborative</title>
  
  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  
  <!-- Chart.js CDN -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
  <!-- Supabase JS Client -->
  <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
  
  <!-- FontAwesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  
  <!-- Google Fonts: Plus Jakarta Sans & JetBrains Mono -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&family=JetBrains+Mono:wght@500;700;800&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-color: #0EA5E9;
      --primary-light: #F0F9FF;
      --primary-dark: #0284C7;
      --primary-ring: rgba(14, 165, 233, 0.25);
      --font-family: 'Plus Jakarta Sans', sans-serif;
    }

    body {
      font-family: var(--font-family);
      -webkit-tap-highlight-color: transparent;
      transition: background-color 0.3s ease, color 0.3s ease;
    }

    .font-mono-num {
      font-family: 'JetBrains Mono', monospace;
    }

    .bg-theme-primary { background-color: var(--primary-color) !important; }
    .text-theme-primary { color: var(--primary-color) !important; }
    .border-theme-primary { border-color: var(--primary-color) !important; }
    .bg-theme-light { background-color: var(--primary-light) !important; }
    .focus-theme-ring:focus { outline: none; box-shadow: 0 0 0 3px var(--primary-ring) !important; }

    .app-card {
      transition: background-color 0.3s ease, border-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
    }

    /* Sisa Saldo Berjalan Deep Navy Gradient Card */
    .sisa-saldo-banner {
      background: radial-gradient(circle at 10% 45%, rgba(255, 255, 255, 0.16) 0%, transparent 48%), linear-gradient(135deg, #071328 0%, #0d2146 55%, #122e5d 100%);
      border: 1px solid rgba(255, 255, 255, 0.18);
      box-shadow: 0 10px 25px -5px rgba(7, 19, 40, 0.45);
    }

    /* Ultra-Premium Curved Bottom Navigation for Mobile */
    .curved-bottom-bar {
      box-shadow: 0 -10px 30px -5px rgba(15, 23, 42, 0.08), 0 -2px 6px -1px rgba(15, 23, 42, 0.03);
      backdrop-filter: blur(16px);
      -webkit-backdrop-filter: blur(16px);
    }
    #navActiveIndicator {
      transition: transform 0.38s cubic-bezier(0.34, 1.56, 0.64, 1);
      box-shadow: 0 10px 25px -3px rgba(14, 165, 233, 0.45), 0 0 0 5px #ffffff, 0 3px 10px rgba(0, 0, 0, 0.06);
    }
    #navSvgCurve {
      transition: transform 0.38s cubic-bezier(0.34, 1.56, 0.64, 1);
      filter: drop-shadow(0 -3px 5px rgba(15, 23, 42, 0.04));
    }
    
    @keyframes navBubblePop {
      0% { transform: scale(0.6); opacity: 0.6; }
      50% { transform: scale(1.25); opacity: 1; }
      100% { transform: scale(1); opacity: 1; }
    }
    .nav-bubble-animate {
      animation: navBubblePop 0.35s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
    }

    /* Custom Scrollbar */
    ::-webkit-scrollbar { width: 4px; height: 4px; }
    ::-webkit-scrollbar-track { background: transparent; }
    ::-webkit-scrollbar-thumb { background: #CBD5E1; border-radius: 9999px; }

    /* Tema Latar Kartu & Penyesuaian Teks Otomatis (Murni Lokal Perangkat) */
    [data-card-theme="putih"] .app-card {
      background-color: #ffffff !important;
      color: #1e293b !important;
      border-color: rgba(226, 232, 240, 0.8) !important;
    }
    [data-card-theme="kucing"] {
      background-color: #faf6f0 !important;
    }
    [data-card-theme="kucing"] .app-card {
      background-color: #fffdf9 !important;
      color: #451a03 !important;
      border-color: #fed7aa !important;
    }
    [data-card-theme="biru_langit"] {
      background-color: #f0f9ff !important;
    }
    [data-card-theme="biru_langit"] .app-card {
      background-color: #ffffff !important;
      color: #0369a1 !important;
      border-color: #bae6fd !important;
    }
    [data-card-theme="pink"] {
      background-color: #fdf2f8 !important;
    }
    [data-card-theme="pink"] .app-card {
      background-color: #ffffff !important;
      color: #9d174d !important;
      border-color: #fbcfe8 !important;
    }
    [data-card-theme="toska"] {
      background-color: #f0fdfa !important;
    }
    [data-card-theme="toska"] .app-card {
      background-color: #ffffff !important;
      color: #0f766e !important;
      border-color: #99f6e4 !important;
    }
    [data-card-theme="abu"] {
      background-color: #f1f5f9 !important;
    }
    [data-card-theme="abu"] .app-card {
      background-color: #ffffff !important;
      color: #334155 !important;
      border-color: #cbd5e1 !important;
    }
    [data-card-theme="gelap"] {
      background-color: #0b1120 !important;
    }
    [data-card-theme="gelap"] .app-card {
      background-color: #1e293b !important;
      color: #f8fafc !important;
      border-color: #334155 !important;
    }
    [data-card-theme="gelap"] .text-slate-900,
    [data-card-theme="gelap"] .text-slate-800,
    [data-card-theme="gelap"] .text-slate-700 {
      color: #f8fafc !important;
    }
    [data-card-theme="gelap"] .text-slate-600,
    [data-card-theme="gelap"] .text-slate-500,
    [data-card-theme="gelap"] .text-slate-400 {
      color: #94a3b8 !important;
    }
    [data-card-theme="mint"] {
      background-color: #f0fdf4 !important;
    }
    [data-card-theme="mint"] .app-card {
      background-color: #ffffff !important;
      color: #064e3b !important;
      border-color: #bbf7d0 !important;
    }
  </style>
</head>

<body class="bg-slate-50 text-slate-800 antialiased min-h-screen relative selection:bg-sky-500 selection:text-white pb-24 md:pb-8" data-theme="sky" data-card-theme="putih">
  <!-- WIDGET APLIKASI KEUANGAN KELUARGA -->
  <div class="max-w-7xl mx-auto p-3 sm:p-4 md:p-6 min-h-screen flex flex-col">

    <!-- TOP NAVIGATION APP BAR (STATUS SESI & TOMBOL KELUAR CEPAT) -->
    <header class="app-card bg-white rounded-2xl p-3 md:p-4 border border-slate-200/80 shadow-xs flex items-center justify-between mb-4">
      <div class="flex items-center gap-3">
        <div class="w-9 h-9 rounded-xl bg-theme-primary text-white flex items-center justify-center font-black text-base shadow-sm">
          <i class="fa-solid fa-vault"></i>
        </div>
        <div>
          <div class="flex items-center gap-2">
            <h1 class="text-sm md:text-base font-black tracking-tight text-slate-900 leading-none">KEUANGAN KELUARGA</h1>
            <span id="topBarRealtimeBadge" class="inline-flex items-center px-2 py-0.5 rounded-full text-[9px] font-bold bg-emerald-100 text-emerald-700">
              <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 mr-1 animate-pulse"></span> Realtime
            </span>
          </div>
          <p class="text-[10px] text-slate-400 font-medium mt-0.5">Buku Kas & Brankas Kolaboratif</p>
        </div>
      </div>

      <!-- Sesi Pengguna Aktif & Tombol Logout Langsung -->
      <div class="flex items-center gap-2">
        <div class="flex items-center gap-2 pl-2 border-l border-slate-200">
          <img id="topBarUserAvatar" src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=160&h=160&fit=crop" class="w-8 h-8 rounded-xl object-cover border border-slate-200 shadow-xs" alt="User">
          <div class="hidden sm:block text-left">
            <span id="topBarUserName" class="text-xs font-black text-slate-800 block leading-tight">Suami</span>
            <span class="text-[9px] text-emerald-600 font-semibold block">Sesi Tersimpan</span>
          </div>
        </div>
        <button onclick="handleLogout()" title="Keluar Akun (Logout)" class="w-8 h-8 rounded-xl bg-slate-100 hover:bg-rose-50 text-slate-500 hover:text-rose-600 flex items-center justify-center text-xs transition">
          <i class="fa-solid fa-arrow-right-from-bracket"></i>
        </button>
      </div>
    </header>

    <div class="flex-1 flex flex-col md:flex-row gap-4">

      <!-- SIDEBAR DESKTOP DENGAN INFO AKUN & LOGOUT -->
      <aside class="hidden md:flex flex-col w-56 lg:w-64 shrink-0 gap-3">
        <div class="app-card p-3 rounded-2xl bg-white border border-slate-200/80 shadow-xs flex items-center justify-between">
          <div class="flex items-center gap-2.5 overflow-hidden">
            <img id="sidebarUserAvatar" src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=160&h=160&fit=crop" class="w-9 h-9 rounded-xl object-cover border border-slate-200 shrink-0" alt="Avatar">
            <div class="overflow-hidden">
              <div class="flex items-center gap-1">
                <span id="sidebarUserName" class="text-xs font-extrabold text-slate-900 block truncate">Bagus Pratama</span>
              </div>
              <div class="flex items-center gap-1">
                <span id="sidebarUserRoleBadge" class="px-1.5 py-0.2 rounded text-[8px] font-extrabold bg-blue-100 text-blue-800">Suami</span>
                <span id="sidebarUserIdLabel" class="text-[9px] text-slate-400 font-mono truncate">ID: bagus</span>
              </div>
            </div>
          </div>
          <button onclick="handleLogout()" title="Keluar Akun (Logout)" class="text-slate-400 hover:text-rose-600 p-1.5 rounded-lg hover:bg-rose-50 transition shrink-0">
            <i class="fa-solid fa-arrow-right-from-bracket text-xs"></i>
          </button>
        </div>

        <!-- Sidebar Navigation Buttons -->
        <nav class="app-card bg-white rounded-2xl p-2 border border-slate-200/80 shadow-xs space-y-1">
          <button onclick="switchView('dashboard')" id="navLinkDashboard" class="sidebar-nav-link flex items-center gap-2.5 px-3 py-2 rounded-xl text-xs font-bold transition text-white bg-theme-primary shadow-xs">
            <i class="fa-solid fa-chart-pie w-4 text-center"></i>
            <span>Dashboard</span>
          </button>

          <button onclick="switchView('pemasukan')" id="navLinkPemasukan" class="sidebar-nav-link flex items-center gap-2.5 px-3 py-2 rounded-xl text-xs font-bold transition text-slate-600 hover:bg-slate-50">
            <i class="fa-solid fa-circle-plus w-4 text-center text-emerald-500"></i>
            <span>Pemasukan (+)</span>
          </button>

          <button onclick="switchView('pengeluaran')" id="navLinkPengeluaran" class="sidebar-nav-link flex items-center gap-2.5 px-3 py-2 rounded-xl text-xs font-bold transition text-slate-600 hover:bg-slate-50">
            <i class="fa-solid fa-circle-minus w-4 text-center text-orange-500"></i>
            <span>Pengeluaran (-)</span>
          </button>

          <button onclick="switchView('riwayat')" id="navLinkRiwayat" class="sidebar-nav-link flex items-center gap-2.5 px-3 py-2 rounded-xl text-xs font-bold transition text-slate-600 hover:bg-slate-50">
            <i class="fa-solid fa-vault w-4 text-center text-amber-500"></i>
            <span>Riwayat & Tabungan</span>
          </button>

          <button onclick="switchView('master')" id="navLinkMaster" class="sidebar-nav-link flex items-center gap-2.5 px-3 py-2 rounded-xl text-xs font-bold transition text-slate-600 hover:bg-slate-50">
            <i class="fa-solid fa-sliders w-4 text-center text-indigo-500"></i>
            <span>Profil & Pengaturan</span>
          </button>
        </nav>

        <!-- Cloud Sync & Supabase Storage Status Banner -->
        <div class="app-card p-3 rounded-2xl bg-white border border-slate-200/80 shadow-xs flex items-center gap-2.5 text-xs">
          <div class="w-7 h-7 rounded-xl bg-emerald-50 text-emerald-600 flex items-center justify-center shrink-0">
            <i class="fa-solid fa-cloud-check"></i>
          </div>
          <div class="overflow-hidden">
            <span class="text-[10px] font-bold text-slate-800 block">Supabase Realtime & Storage</span>
            <span id="sidebarSyncLabel" class="text-[9px] text-emerald-600 font-semibold block truncate">Bucket Struk Siap</span>
          </div>
        </div>
      </aside>

      <main class="flex-1 w-full flex flex-col gap-4 overflow-hidden">
        
        <div id="viewsContainer">
          
          <!-- TAB: DASHBOARD -->
          <section id="viewDashboard" class="space-y-4">
            
            <!-- 1. KARTU SISA SALDO BERJALAN MANDIRI DI PALING ATAS -->
            <div class="sisa-saldo-banner relative overflow-hidden rounded-3xl p-5 md:p-6 text-white">
              <div class="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div>
                  <div class="flex items-center gap-2">
                    <span class="w-2.5 h-2.5 rounded-full bg-sky-400 animate-pulse"></span>
                    <span class="text-[10px] md:text-xs font-black uppercase tracking-widest text-sky-200">SISA SALDO BERJALAN</span>
                    <span id="badgeBudgetStatus" class="px-2 py-0.5 rounded-full text-[9px] font-bold bg-white/10 text-sky-200 border border-white/15">Siklus Tgl 10 Aktif</span>
                  </div>
                  <!-- Giant Typography Nominal Utama -->
                  <div id="summarySaldo" class="text-3xl sm:text-4xl md:text-5xl font-black font-mono-num text-white tracking-tight mt-1.5 leading-none">
                    Rp 0
                  </div>
                  <p class="text-[11px] text-slate-300 mt-1.5">Sisa kas periode berjalan (Otomatis ditabung setiap tgl 10 gajian)</p>
                </div>

                <!-- Status Saldo Indikator -->
                <div class="flex items-center gap-2 self-start sm:self-center">
                  <span id="summarySaldoStatus" class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-extrabold bg-emerald-500/20 text-emerald-300 border border-emerald-500/30 backdrop-blur-sm">
                    <i class="fa-solid fa-shield-check"></i> Aman & Terkendali
                  </span>
                </div>
              </div>
            </div>

            <!-- 2. TIGA KARTU BERBARIS: Gaji Pokok, Non-Gaji, dan Pengeluaran -->
            <div class="grid grid-cols-3 gap-2 sm:gap-3 md:gap-4">
              <!-- Gaji Pokok Card -->
              <div class="app-card bg-white rounded-2xl p-3 md:p-4 border border-slate-200/80 shadow-xs relative overflow-hidden flex flex-col justify-between">
                <div>
                  <span class="text-[9px] md:text-[10px] font-bold uppercase tracking-wider text-slate-400 block truncate">Gaji Pokok</span>
                  <div id="summaryGaji" class="text-xs sm:text-lg md:text-2xl font-black text-[#22C55E] font-mono-num mt-1 truncate">Rp 0</div>
                </div>
                <span class="text-[8px] md:text-[10px] text-slate-400 mt-1 block truncate">Pondasi Bulanan</span>
              </div>

              <!-- Non-Gaji Card -->
              <div class="app-card bg-white rounded-2xl p-3 md:p-4 border border-slate-200/80 shadow-xs relative overflow-hidden flex flex-col justify-between">
                <div>
                  <span class="text-[9px] md:text-[10px] font-bold uppercase tracking-wider text-slate-400 block truncate">Non-Gaji</span>
                  <div id="summaryNonGaji" class="text-xs sm:text-lg md:text-2xl font-black text-[#10B981] font-mono-num mt-1 truncate">Rp 0</div>
                </div>
                <span class="text-[8px] md:text-[10px] text-slate-400 mt-1 block truncate">Bonus & Usaha</span>
              </div>

              <!-- Pengeluaran Card -->
              <div class="app-card bg-white rounded-2xl p-3 md:p-4 border border-slate-200/80 shadow-xs relative overflow-hidden flex flex-col justify-between">
                <div>
                  <span class="text-[9px] md:text-[10px] font-bold uppercase tracking-wider text-slate-400 block truncate">Pengeluaran</span>
                  <div id="summaryPengeluaran" class="text-xs sm:text-lg md:text-2xl font-black text-[#F97316] font-mono-num mt-1 truncate">Rp 0</div>
                </div>
                <span class="text-[8px] md:text-[10px] text-slate-400 mt-1 block truncate"><span id="summaryExpenseCount">0</span> transaksi</span>
              </div>
            </div>

            <!-- 3. PENCARIAN & FILTER TANGGAL -->
            <div class="app-card bg-white rounded-2xl p-2.5 md:p-3 border border-slate-200/80 shadow-xs space-y-2">
              <div class="flex flex-col sm:flex-row items-stretch sm:items-center gap-2">
                <div class="relative flex-1">
                  <i class="fa-solid fa-magnifying-glass absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-[11px]"></i>
                  <input id="dashSearchText" type="text" oninput="applyDashboardFilter()" placeholder="Cari catatan, pos, atau pengisi..." class="w-full pl-8 pr-3 py-1.5 bg-slate-50 border border-slate-200 rounded-xl text-[11px] font-medium focus-theme-ring">
                </div>

                <div class="flex items-center gap-1.5">
                  <div class="flex items-center gap-1 bg-slate-50 border border-slate-200 px-2 py-1 rounded-xl text-[10px]">
                    <span class="text-slate-400 font-bold">Dari:</span>
                    <input id="dashStartDate" type="date" onchange="applyDashboardFilter()" class="bg-transparent text-slate-800 font-semibold outline-none text-[10px]">
                  </div>
                  <div class="flex items-center gap-1 bg-slate-50 border border-slate-200 px-2 py-1 rounded-xl text-[10px]">
                    <span class="text-slate-400 font-bold">Ke:</span>
                    <input id="dashEndDate" type="date" onchange="applyDashboardFilter()" class="bg-transparent text-slate-800 font-semibold outline-none text-[10px]">
                  </div>
                  <button onclick="resetDashboardFilter()" title="Reset Filter" class="px-2 py-1 bg-slate-100 hover:bg-slate-200 rounded-xl text-[10px] text-slate-600 font-bold">
                    <i class="fa-solid fa-rotate-left"></i>
                  </button>
                </div>
              </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-12 gap-3 md:gap-4">
              <!-- Line Chart: Tren Pengeluaran Harian -->
              <div class="app-card lg:col-span-7 bg-white rounded-2xl p-3 md:p-4 border border-slate-200/80 shadow-xs">
                <div class="flex items-center justify-between mb-2">
                  <span class="text-xs font-bold text-slate-800">Tren Pengeluaran Harian</span>
                  <span id="peakExpenseLabel" class="text-[10px] font-bold px-2 py-0.5 bg-orange-50 text-[#F97316] rounded-md">Puncak: Rp 0</span>
                </div>
                <div class="relative h-[180px] md:h-[220px] w-full">
                  <canvas id="expenseLineChart"></canvas>
                </div>
              </div>

              <!-- Donut Chart: Komposisi Kas -->
              <div class="app-card lg:col-span-5 bg-white rounded-2xl p-3 md:p-4 border border-slate-200/80 shadow-xs flex flex-col justify-between">
                <div class="flex items-center justify-between mb-2">
                  <span class="text-xs font-bold text-slate-800">Komposisi Kas</span>
                  <div class="flex gap-1 bg-slate-100 p-0.5 rounded-lg text-[10px] font-semibold">
                    <button id="btnChartExp" onclick="switchDonutChart('expense')" class="px-2 py-0.5 rounded bg-white text-slate-900 shadow-xs">Pengeluaran</button>
                    <button id="btnChartInc" onclick="switchDonutChart('income')" class="px-2 py-0.5 rounded text-slate-500">Pemasukan</button>
                  </div>
                </div>
                <div class="relative flex items-center justify-center h-[140px] md:h-[160px]">
                  <canvas id="categoryDonutChart"></canvas>
                  <div class="absolute inset-0 flex flex-col items-center justify-center pointer-events-none">
                    <span class="text-[8px] font-bold text-slate-400" id="donutCenterLabel">TOTAL</span>
                    <span id="donutCenterTotal" class="text-xs font-black text-slate-800 font-mono-num">Rp 0</span>
                  </div>
                </div>
                <div id="donutLegendList" class="mt-2 flex flex-wrap gap-1.5 text-[9px]"></div>
              </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-3 md:gap-4">
              <!-- Mini Income Table -->
              <div class="app-card bg-white rounded-2xl border border-slate-200/80 shadow-xs overflow-hidden">
                <div class="p-2.5 bg-emerald-50/60 border-b border-slate-100 flex items-center justify-between">
                  <div class="flex items-center gap-1.5 text-xs font-extrabold text-emerald-800">
                    <i class="fa-solid fa-circle-plus text-emerald-600"></i>
                    <span>Pemasukan Terbaru</span>
                  </div>
                  <button onclick="switchView('pemasukan')" class="text-[10px] font-bold text-emerald-700 hover:underline">Lihat Semua &rarr;</button>
                </div>
                <div class="overflow-x-auto">
                  <table class="w-full text-left border-collapse text-[10px]">
                    <thead class="bg-slate-50 text-slate-400 uppercase font-bold text-[8px] tracking-wider border-b border-slate-100">
                      <tr>
                        <th class="py-1.5 px-2">Tgl</th>
                        <th class="py-1.5 px-2">Kategori</th>
                        <th class="py-1.5 px-2">Oleh</th>
                        <th class="py-1.5 px-2 text-right">Nominal</th>
                      </tr>
                    </thead>
                    <tbody id="dashIncomeMiniTable" class="divide-y divide-slate-100"></tbody>
                  </table>
                </div>
              </div>

              <!-- Mini Expense Table -->
              <div class="app-card bg-white rounded-2xl border border-slate-200/80 shadow-xs overflow-hidden">
                <div class="p-2.5 bg-orange-50/60 border-b border-slate-100 flex items-center justify-between">
                  <div class="flex items-center gap-1.5 text-xs font-extrabold text-orange-800">
                    <i class="fa-solid fa-circle-minus text-[#F97316]"></i>
                    <span>Pengeluaran Terbaru</span>
                  </div>
                  <button onclick="switchView('pengeluaran')" class="text-[10px] font-bold text-orange-700 hover:underline">Lihat Semua &rarr;</button>
                </div>
                <div class="overflow-x-auto">
                  <table class="w-full text-left border-collapse text-[10px]">
                    <thead class="bg-slate-50 text-slate-400 uppercase font-bold text-[8px] tracking-wider border-b border-slate-100">
                      <tr>
                        <th class="py-1.5 px-2">Tgl</th>
                        <th class="py-1.5 px-2">Kategori</th>
                        <th class="py-1.5 px-2">Oleh</th>
                        <th class="py-1.5 px-2 text-right">Nominal</th>
                      </tr>
                    </thead>
                    <tbody id="dashExpenseMiniTable" class="divide-y divide-slate-100"></tbody>
                  </table>
                </div>
              </div>
            </div>

          </section>

          <!-- TAB: PEMASUKAN -->
          <section id="viewPemasukan" class="space-y-4 hidden">
            <div class="relative overflow-hidden rounded-3xl p-5 md:p-6 text-white shadow-md border border-emerald-500/30 bg-gradient-to-br from-[#064e3b] via-[#047857] to-[#059669]">
              <div class="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div>
                  <div class="flex items-center gap-2">
                    <span class="w-2.5 h-2.5 rounded-full bg-emerald-300 animate-pulse"></span>
                    <span class="text-[10px] md:text-xs font-black uppercase tracking-widest text-emerald-200">TOTAL PEMASUKAN</span>
                  </div>
                  <div id="headerTotalIncome" class="text-3xl sm:text-4xl md:text-5xl font-black font-mono-num text-white tracking-tight mt-1.5 leading-none">
                    Rp 0
                  </div>
                  <p class="text-[11px] text-emerald-100 mt-1.5">Dana masuk (Gaji Pokok, Non-Gaji, & Tarik Tabungan)</p>
                </div>

                <div class="self-start sm:self-center">
                  <button onclick="openModal('modalAddIncome')" class="inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-2xl bg-white text-emerald-800 hover:bg-emerald-50 text-xs font-black shadow-md transition transform hover:-translate-y-0.5">
                    <i class="fa-solid fa-circle-plus text-emerald-600 text-sm"></i>
                    <span>Tambah Pemasukan</span>
                  </button>
                </div>
              </div>
            </div>

            <!-- Filter Bar Pemasukan -->
            <div class="app-card bg-white rounded-2xl p-2.5 border border-slate-200/80 shadow-xs space-y-2">
              <div class="flex flex-col sm:flex-row gap-2">
                <div class="relative flex-1">
                  <i class="fa-solid fa-magnifying-glass absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-[11px]"></i>
                  <input id="searchIncomeText" type="text" oninput="renderIncomeTable()" placeholder="Cari catatan atau sumber..." class="w-full pl-8 pr-3 py-1.5 bg-slate-50 border border-slate-200 rounded-xl text-[11px] font-medium focus-theme-ring">
                </div>
                <div class="flex items-center gap-1.5">
                  <div class="flex items-center gap-1 bg-slate-50 border border-slate-200 px-2 py-1 rounded-xl text-[10px]">
                    <span class="text-slate-400 font-bold">Dari:</span>
                    <input id="inputIncomeFilterStart" type="date" onchange="renderIncomeTable()" class="bg-transparent text-slate-800 font-semibold outline-none text-[10px]">
                  </div>
                  <div class="flex items-center gap-1 bg-slate-50 border border-slate-200 px-2 py-1 rounded-xl text-[10px]">
                    <span class="text-slate-400 font-bold">Ke:</span>
                    <input id="inputIncomeFilterEnd" type="date" onchange="renderIncomeTable()" class="bg-transparent text-slate-800 font-semibold outline-none text-[10px]">
                  </div>
                  <button onclick="resetIncomeFilter()" class="px-2 py-1 bg-slate-100 hover:bg-slate-200 rounded-xl text-[10px] text-slate-600 font-bold">
                    <i class="fa-solid fa-rotate-left"></i>
                  </button>
                </div>
              </div>

              <div class="flex items-center gap-2">
                <select id="filterIncomeType" onchange="renderIncomeTable()" class="px-2 py-1 bg-slate-50 border border-slate-200 rounded-xl text-[10px] font-semibold text-slate-700 flex-1">
                  <option value="all">Semua Pos (Gaji, Non-Gaji, Tabungan)</option>
                  <option value="gaji">Gaji Pokok</option>
                  <option value="non_gaji">Non-Gaji</option>
                  <option value="tarik_tabungan">Ambil Tabungan</option>
                </select>

                <select id="filterIncomeAuthor" onchange="renderIncomeTable()" class="px-2 py-1 bg-slate-50 border border-slate-200 rounded-xl text-[10px] font-semibold text-slate-700 flex-1">
                  <option value="all">Semua Pengisi</option>
                  <option value="Suami">Suami</option>
                  <option value="Istri">Istri</option>
                </select>
              </div>
            </div>

            <!-- Tabel Data Pemasukan -->
            <div class="app-card bg-white rounded-2xl border border-slate-200/80 shadow-xs overflow-hidden">
              <div class="p-2.5 border-b border-slate-100 flex items-center justify-between text-xs">
                <span class="font-bold text-slate-500 uppercase text-[10px]">Daftar Pemasukan</span>
                <span id="incomeCountBadge" class="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-50 text-emerald-700">0 Data • Rp 0</span>
              </div>
              <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse text-xs">
                  <thead class="bg-slate-50 text-slate-400 uppercase font-bold text-[9px] tracking-wider border-b border-slate-100">
                    <tr>
                      <th class="py-2 px-3">Tanggal</th>
                      <th class="py-2 px-3">Pos</th>
                      <th class="py-2 px-3">Catatan</th>
                      <th class="py-2 px-3">Pengisi</th>
                      <th class="py-2 px-3 text-right">Nominal</th>
                      <th class="py-2 px-3 text-center">Struk</th>
                    </tr>
                  </thead>
                  <tbody id="incomeTableBody" class="divide-y divide-slate-100 text-[11px]"></tbody>
                  <tfoot class="bg-emerald-50/50 font-bold border-t border-slate-100 text-[11px]">
                    <tr>
                      <td colspan="4" class="py-2 px-3 text-right text-slate-600">Total Pemasukan (Tersaring):</td>
                      <td id="tableFooterIncomeTotal" class="py-2 px-3 text-right font-mono-num text-emerald-600 font-extrabold text-xs">Rp 0</td>
                      <td></td>
                    </tr>
                  </tfoot>
                </table>
              </div>
            </div>
          </section>

          <!-- TAB: PENGELUARAN -->
          <section id="viewPengeluaran" class="space-y-4 hidden">
            <div class="relative overflow-hidden rounded-3xl p-5 md:p-6 text-white shadow-md border border-orange-500/30 bg-gradient-to-br from-[#7c2d12] via-[#c2410c] to-[#ea580c]">
              <div class="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div>
                  <div class="flex items-center gap-2">
                    <span class="w-2.5 h-2.5 rounded-full bg-orange-300 animate-pulse"></span>
                    <span class="text-[10px] md:text-xs font-black uppercase tracking-widest text-orange-200">TOTAL PENGELUARAN</span>
                  </div>
                  <div id="headerTotalExpense" class="text-3xl sm:text-4xl md:text-5xl font-black font-mono-num text-white tracking-tight mt-1.5 leading-none">
                    Rp 0
                  </div>
                  <p class="text-[11px] text-orange-100 mt-1.5">Seluruh pos belanja operasional kas keluarga</p>
                </div>

                <div class="self-start sm:self-center">
                  <button onclick="openModal('modalAddExpense')" class="inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-2xl bg-white text-orange-800 hover:bg-orange-50 text-xs font-black shadow-md transition transform hover:-translate-y-0.5">
                    <i class="fa-solid fa-circle-minus text-[#ea580c] text-sm"></i>
                    <span>Tambah Pengeluaran</span>
                  </button>
                </div>
              </div>
            </div>

            <!-- Filter Bar Pengeluaran -->
            <div class="app-card bg-white rounded-2xl p-2.5 border border-slate-200/80 shadow-xs space-y-2">
              <div class="flex flex-col sm:flex-row gap-2">
                <div class="relative flex-1">
                  <i class="fa-solid fa-magnifying-glass absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-[11px]"></i>
                  <input id="searchExpenseText" type="text" oninput="renderExpenseTable()" placeholder="Cari keperluan belanja..." class="w-full pl-8 pr-3 py-1.5 bg-slate-50 border border-slate-200 rounded-xl text-[11px] font-medium focus-theme-ring">
                </div>
                <div class="flex items-center gap-1.5">
                  <div class="flex items-center gap-1 bg-slate-50 border border-slate-200 px-2 py-1 rounded-xl text-[10px]">
                    <span class="text-slate-400 font-bold">Dari:</span>
                    <input id="inputExpenseFilterStart" type="date" onchange="renderExpenseTable()" class="bg-transparent text-slate-800 font-semibold outline-none text-[10px]">
                  </div>
                  <div class="flex items-center gap-1 bg-slate-50 border border-slate-200 px-2 py-1 rounded-xl text-[10px]">
                    <span class="text-slate-400 font-bold">Ke:</span>
                    <input id="inputExpenseFilterEnd" type="date" onchange="renderExpenseTable()" class="bg-transparent text-slate-800 font-semibold outline-none text-[10px]">
                  </div>
                  <button onclick="resetExpenseFilter()" class="px-2 py-1 bg-slate-100 hover:bg-slate-200 rounded-xl text-[10px] text-slate-600 font-bold">
                    <i class="fa-solid fa-rotate-left"></i>
                  </button>
                </div>
              </div>

              <div class="flex items-center gap-2">
                <select id="filterExpenseCategory" onchange="renderExpenseTable()" class="px-2 py-1 bg-slate-50 border border-slate-200 rounded-xl text-[10px] font-semibold text-slate-700 flex-1">
                  <option value="all">Semua Kategori</option>
                </select>

                <select id="filterExpenseAuthor" onchange="renderExpenseTable()" class="px-2 py-1 bg-slate-50 border border-slate-200 rounded-xl text-[10px] font-semibold text-slate-700 flex-1">
                  <option value="all">Semua Pengisi</option>
                  <option value="Suami">Suami</option>
                  <option value="Istri">Istri</option>
                </select>
              </div>
            </div>

            <!-- Tabel Data Pengeluaran -->
            <div class="app-card bg-white rounded-2xl border border-slate-200/80 shadow-xs overflow-hidden">
              <div class="p-2.5 border-b border-slate-100 flex items-center justify-between text-xs">
                <span class="font-bold text-slate-500 uppercase text-[10px]">Daftar Pengeluaran</span>
                <span id="expenseCountBadge" class="px-2 py-0.5 rounded-full text-[10px] font-bold bg-orange-50 text-orange-700">0 Data • Rp 0</span>
              </div>
              <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse text-xs">
                  <thead class="bg-slate-50 text-slate-400 uppercase font-bold text-[9px] tracking-wider border-b border-slate-100">
                    <tr>
                      <th class="py-2 px-3">Tanggal</th>
                      <th class="py-2 px-3">Kategori</th>
                      <th class="py-2 px-3">Keterangan</th>
                      <th class="py-2 px-3">Pengisi</th>
                      <th class="py-2 px-3 text-right">Nominal</th>
                      <th class="py-2 px-3 text-center">Struk</th>
                    </tr>
                  </thead>
                  <tbody id="expenseTableBody" class="divide-y divide-slate-100 text-[11px]"></tbody>
                  <tfoot class="bg-orange-50/50 font-bold border-t border-slate-100 text-[11px]">
                    <tr>
                      <td colspan="4" class="py-2 px-3 text-right text-slate-600">Total Pengeluaran (Tersaring):</td>
                      <td id="tableFooterExpenseTotal" class="py-2 px-3 text-right font-mono-num text-orange-600 font-extrabold text-xs">Rp 0</td>
                      <td></td>
                    </tr>
                  </tfoot>
                </table>
              </div>
            </div>
          </section>

          <!-- TAB: RIWAYAT & TABUNGAN -->
          <section id="viewRiwayat" class="space-y-4 hidden">
            <div class="relative overflow-hidden rounded-3xl p-5 md:p-6 shadow-md border border-amber-500/30 bg-gradient-to-br from-slate-900 via-slate-800 to-amber-950 text-white">
              <div class="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div>
                  <div class="flex items-center gap-2">
                    <span class="w-2.5 h-2.5 rounded-full bg-amber-400 animate-pulse"></span>
                    <span class="text-[10px] md:text-xs font-black uppercase tracking-widest text-amber-300">TOTAL BRANKAS TABUNGAN KELUARGA</span>
                  </div>
                  <div id="riwayatTabunganBesar" class="text-3xl sm:text-4xl md:text-5xl font-black font-mono-num text-amber-300 tracking-tight mt-1.5 leading-none">
                    Rp 0
                  </div>
                  <p class="text-[11px] text-slate-300 mt-1.5">Surplus otomatis tiap tanggal 10 & dana darurat keluarga</p>
                </div>
                <div class="self-start sm:self-center">
                  <button onclick="openTarikTabunganModal()" class="inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-2xl bg-amber-500 hover:bg-amber-600 font-black text-slate-950 text-xs shadow-md transition transform hover:-translate-y-0.5">
                    <i class="fa-solid fa-hand-holding-dollar text-sm"></i>
                    <span>Tarik Tabungan ke Kas</span>
                  </button>
                </div>
              </div>
            </div>

            <!-- Riwayat Mutasi Tabungan -->
            <div class="app-card bg-white rounded-2xl p-4 border border-slate-200/80 shadow-xs space-y-3">
              <div>
                <h3 class="text-xs font-black text-slate-900 uppercase tracking-wider">Mutasi Brankas Tabungan</h3>
                <p class="text-[10px] text-slate-400">Riwayat surplus penutupan gajian & penarikan dana cadangan</p>
              </div>
              <div id="savingsHistoryTable" class="divide-y divide-slate-100 text-xs"></div>
            </div>
          </section>

          <!-- TAB: MASTER & PROFIL -->
          <section id="viewMaster" class="space-y-4 hidden">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-3 md:gap-4">
              <!-- Profil Suami Card -->
              <div id="cardProfileSuami" class="app-card bg-white rounded-2xl p-4 border border-slate-200/80 shadow-xs flex flex-col justify-between">
                <div>
                  <div class="flex items-center justify-between mb-3">
                    <span class="px-2 py-0.5 rounded-full text-[10px] font-extrabold bg-blue-100 text-blue-700">Peran: Suami</span>
                    <button onclick="editProfile('Suami')" class="text-xs text-slate-500 hover:text-slate-800 font-bold"><i class="fa-solid fa-pen-to-square mr-1"></i>Edit Akun</button>
                  </div>
                  <div class="flex items-center gap-3">
                    <img id="profileAvatarSuami" src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=160&h=160&fit=crop&crop=faces" class="w-12 h-12 rounded-xl object-cover border-2 border-blue-500 shadow-xs" alt="Foto Suami">
                    <div>
                      <h3 id="profileNameSuami" class="text-sm font-extrabold text-slate-900">Bagus Pratama</h3>
                      <p id="profileUserSuami" class="text-[11px] text-slate-500 font-mono">ID: bagus</p>
                      <span class="text-[10px] text-slate-400">Total Catatan: <strong id="statsInputSuami">0</strong></span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Profil Istri Card -->
              <div id="cardProfileIstri" class="app-card bg-white rounded-2xl p-4 border border-slate-200/80 shadow-xs flex flex-col justify-between">
                <div>
                  <div class="flex items-center justify-between mb-3">
                    <span class="px-2 py-0.5 rounded-full text-[10px] font-extrabold bg-rose-100 text-rose-700">Peran: Istri</span>
                    <button onclick="editProfile('Istri')" class="text-xs text-slate-500 hover:text-slate-800 font-bold"><i class="fa-solid fa-pen-to-square mr-1"></i>Edit Akun</button>
                  </div>
                  <div class="flex items-center gap-3">
                    <img id="profileAvatarIstri" src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=160&h=160&fit=crop&crop=faces" class="w-12 h-12 rounded-xl object-cover border-2 border-rose-500 shadow-xs" alt="Foto Istri">
                    <div>
                      <h3 id="profileNameIstri" class="text-sm font-extrabold text-slate-900">Anindya Putri</h3>
                      <p id="profileUserIstri" class="text-[11px] text-slate-500 font-mono">ID: anindya</p>
                      <span class="text-[10px] text-slate-400">Total Catatan: <strong id="statsInputIstri">0</strong></span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pengaturan Tema & Warna Kartu (HANYA BERLAKU DI LOKAL PERANGKAT INI) -->
            <div class="app-card bg-white rounded-2xl p-4 border border-slate-200/80 shadow-xs space-y-3">
              <div class="flex items-center justify-between">
                <div>
                  <h3 class="text-xs font-black text-slate-900 uppercase tracking-wider flex items-center gap-1.5">
                    <i class="fa-solid fa-palette text-theme-primary"></i> Tema Tampilan & Warna Kartu
                  </h3>
                  <p class="text-[10px] text-slate-400">Hanya berlaku di perangkat ini (Tersimpan di lokal HP, tidak mempengaruhi HP pasangan)</p>
                </div>
                <span class="px-2 py-0.5 rounded-full text-[9px] font-bold bg-slate-100 text-slate-600">Lokal HP</span>
              </div>

              <!-- Pilihan Warna Tema Kartu -->
              <div>
                <label class="block font-bold text-slate-700 text-xs mb-1.5">Pilihan Warna Tema</label>
                <div class="grid grid-cols-2 sm:grid-cols-4 gap-2">
                  <button type="button" onclick="setCardTheme('putih')" class="theme-card-btn p-2 rounded-xl border border-slate-200 text-left hover:border-slate-400 transition flex items-center gap-2" data-val="putih">
                    <span class="w-4 h-4 rounded-full bg-white border border-slate-300 shrink-0"></span>
                    <span class="text-[10px] font-bold text-slate-800">Putih</span>
                  </button>
                  <button type="button" onclick="setCardTheme('biru_langit')" class="theme-card-btn p-2 rounded-xl border border-slate-200 text-left hover:border-slate-400 transition flex items-center gap-2" data-val="biru_langit">
                    <span class="w-4 h-4 rounded-full bg-[#38bdf8] border border-sky-400 shrink-0"></span>
                    <span class="text-[10px] font-bold text-sky-900">Biru Langit</span>
                  </button>
                  <button type="button" onclick="setCardTheme('pink')" class="theme-card-btn p-2 rounded-xl border border-slate-200 text-left hover:border-slate-400 transition flex items-center gap-2" data-val="pink">
                    <span class="w-4 h-4 rounded-full bg-[#f472b6] border border-pink-400 shrink-0"></span>
                    <span class="text-[10px] font-bold text-pink-900">Pink</span>
                  </button>
                  <button type="button" onclick="setCardTheme('toska')" class="theme-card-btn p-2 rounded-xl border border-slate-200 text-left hover:border-slate-400 transition flex items-center gap-2" data-val="toska">
                    <span class="w-4 h-4 rounded-full bg-[#2dd4bf] border border-teal-400 shrink-0"></span>
                    <span class="text-[10px] font-bold text-teal-900">Toska</span>
                  </button>
                  <button type="button" onclick="setCardTheme('abu')" class="theme-card-btn p-2 rounded-xl border border-slate-200 text-left hover:border-slate-400 transition flex items-center gap-2" data-val="abu">
                    <span class="w-4 h-4 rounded-full bg-[#94a3b8] border border-slate-400 shrink-0"></span>
                    <span class="text-[10px] font-bold text-slate-800">Abu-abu</span>
                  </button>
                  <button type="button" onclick="setCardTheme('kucing')" class="theme-card-btn p-2 rounded-xl border border-slate-200 text-left hover:border-slate-400 transition flex items-center gap-2" data-val="kucing">
                    <span class="w-4 h-4 rounded-full bg-[#faf6f0] border border-amber-300 shrink-0"></span>
                    <span class="text-[10px] font-bold text-amber-900">Kucing 🐾</span>
                  </button>
                  <button type="button" onclick="setCardTheme('mint')" class="theme-card-btn p-2 rounded-xl border border-slate-200 text-left hover:border-slate-400 transition flex items-center gap-2" data-val="mint">
                    <span class="w-4 h-4 rounded-full bg-[#ecfdf5] border border-emerald-300 shrink-0"></span>
                    <span class="text-[10px] font-bold text-emerald-900">Mint</span>
                  </button>
                  <button type="button" onclick="setCardTheme('gelap')" class="theme-card-btn p-2 rounded-xl border border-slate-200 text-left hover:border-slate-400 transition flex items-center gap-2" data-val="gelap">
                    <span class="w-4 h-4 rounded-full bg-[#1e293b] border border-slate-500 shrink-0"></span>
                    <span class="text-[10px] font-bold text-slate-800">Gelap</span>
                  </button>
                </div>
              </div>
            </div>

            <!-- Master Data Restricted Section (Khusus Suami) -->
            <div id="masterDataRestrictedSection" class="app-card bg-white rounded-2xl p-4 border border-slate-200/80 shadow-xs space-y-3">
              <div class="flex items-center justify-between">
                <div>
                  <h3 class="text-xs font-black text-slate-900 uppercase tracking-wider flex items-center gap-1.5">
                    <i class="fa-solid fa-lock text-amber-500"></i> Master Data & Pengaturan Sistem
                  </h3>
                  <p class="text-[10px] text-slate-400">Pengaturan lanjutan khusus peran Suami</p>
                </div>
                <span id="badgeSuamiAccess" class="px-2 py-0.5 rounded-full text-[10px] font-bold bg-blue-100 text-blue-800">Khusus Suami</span>
              </div>

              <!-- Foto Latar Halaman Login -->
              <div class="p-3 bg-slate-50 rounded-xl border border-slate-200/80 space-y-2">
                <label class="block font-bold text-slate-700 text-xs">URL Foto Latar Belakang Layar Masuk (Login)</label>
                <div class="flex gap-2">
                  <input id="inputMasterLoginBgUrl" type="url" placeholder="https://images.unsplash.com/photo-..." class="flex-1 px-3 py-1.5 bg-white border border-slate-200 rounded-xl text-xs font-mono">
                  <button onclick="saveLoginBgSetting()" class="px-3 py-1.5 rounded-xl bg-slate-900 text-white font-bold text-xs hover:bg-slate-800">Simpan</button>
                  <button onclick="resetLoginBgSetting()" class="px-2 py-1.5 rounded-xl border border-slate-200 bg-white text-slate-600 text-xs">Reset</button>
                </div>
              </div>

              <!-- Supabase Storage Status Info -->
              <div class="p-3 bg-slate-50 rounded-xl border border-slate-200/80 flex items-center justify-between text-xs">
                <div>
                  <span class="font-bold text-slate-800 block">Penyimpanan Nota: Supabase Storage Bucket</span>
                  <span class="text-[10px] text-slate-500 font-mono">Bucket: public/receipts (Hemat Egress Kuota Aktif)</span>
                </div>
                <span class="px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-800">Terhubung</span>
              </div>

              <!-- Master Categories List -->
              <div class="pt-2">
                <div class="flex items-center justify-between mb-2">
                  <span class="text-xs font-bold text-slate-800">Kategori Transaksi</span>
                  <button onclick="openModal('modalAddCategory')" class="px-2.5 py-1 rounded-xl bg-slate-900 text-white text-[10px] font-bold">
                    <i class="fa-solid fa-plus mr-1"></i> Tambah
                  </button>
                </div>
                <div id="masterCategoryList" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-2"></div>
              </div>
            </div>

            <!-- KARTU KELUAR AKUN (LOGOUT) DENGAN INFORMASI SESI PERMANEN -->
            <div class="app-card bg-white rounded-2xl p-4 border border-rose-100 shadow-xs flex items-center justify-between">
              <div>
                <h4 class="text-xs font-bold text-slate-800 flex items-center gap-1.5">
                  <i class="fa-solid fa-shield-halved text-emerald-500"></i> Sesi Akun Aktif & Tersimpan
                </h4>
                <p class="text-[10px] text-slate-400 mt-0.5">Aplikasi tidak akan meminta login lagi saat dibuka. Anda hanya perlu login kembali jika menekan tombol keluar di bawah ini.</p>
              </div>
              <button type="button" onclick="handleLogout()" class="px-3.5 py-2 rounded-xl bg-rose-50 hover:bg-rose-100 text-rose-600 border border-rose-200 font-bold text-xs flex items-center gap-1.5 transition shadow-xs shrink-0">
                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                <span>Keluar Akun</span>
              </button>
            </div>
          </section>

        </div>
      </main>

    </div>

    <!-- REFINED MOBILE CURVED BOTTOM NAVIGATION -->
    <div class="md:hidden fixed bottom-0 left-0 right-0 z-40">
      <div class="relative w-full h-[68px] bg-white/95 border-t border-slate-100 curved-bottom-bar flex items-center justify-around px-1 pb-[env(safe-area-inset-bottom,0px)]">
        
        <!-- SVG Curved Notch Layer -->
        <div id="navSvgCurve" class="absolute -top-4 left-0 w-[110px] h-6 pointer-events-none transition-transform duration-300" style="transform: translateX(10px);">
          <svg viewBox="0 0 110 24" fill="#FFFFFF" class="w-full h-full">
            <path d="M0,24 C18,24 24,20 33,12 C42,4 47,0 55,0 C63,0 68,4 77,12 C86,20 92,24 110,24 Z"></path>
          </svg>
        </div>

        <!-- Floating Active Circle Indicator -->
        <div id="navActiveIndicator" class="absolute -top-5 left-0 w-[52px] h-[52px] rounded-full bg-gradient-to-tr from-[#0284c7] via-[#0ea5e9] to-[#38bdf8] text-white flex items-center justify-center pointer-events-none transition-transform duration-300 text-lg" style="transform: translateX(26px);">
          <i id="navActiveIcon" class="fa-solid fa-chart-pie transition-transform duration-200"></i>
        </div>

        <button onclick="handleMobileNavSwitch('dashboard', 0)" class="mobile-nav-item relative flex-1 flex flex-col items-center justify-center h-full py-1 transition group z-10" data-index="0">
          <i class="mobile-nav-icon fa-solid fa-chart-pie text-base transition-all duration-300 text-theme-primary"></i>
          <span class="mobile-nav-label text-[9px] mt-1 transition-all duration-300 text-theme-primary font-extrabold tracking-tight">Dashboard</span>
          <span class="mobile-nav-dot w-1 h-1 rounded-full bg-theme-primary mt-0.5 transition-all duration-300"></span>
        </button>

        <button onclick="handleMobileNavSwitch('pemasukan', 1)" class="mobile-nav-item relative flex-1 flex flex-col items-center justify-center h-full py-1 transition group z-10" data-index="1">
          <i class="mobile-nav-icon fa-solid fa-circle-plus text-sm text-slate-400 group-hover:text-slate-600 transition-all duration-300"></i>
          <span class="mobile-nav-label text-[9px] mt-1 transition-all duration-300 text-slate-400 font-semibold tracking-tight">Masuk</span>
          <span class="mobile-nav-dot w-1 h-1 rounded-full bg-theme-primary mt-0.5 opacity-0 scale-0 transition-all duration-300"></span>
        </button>

        <button onclick="handleMobileNavSwitch('pengeluaran', 2)" class="mobile-nav-item relative flex-1 flex flex-col items-center justify-center h-full py-1 transition group z-10" data-index="2">
          <i class="mobile-nav-icon fa-solid fa-circle-minus text-sm text-slate-400 group-hover:text-slate-600 transition-all duration-300"></i>
          <span class="mobile-nav-label text-[9px] mt-1 transition-all duration-300 text-slate-400 font-semibold tracking-tight">Keluar</span>
          <span class="mobile-nav-dot w-1 h-1 rounded-full bg-theme-primary mt-0.5 opacity-0 scale-0 transition-all duration-300"></span>
        </button>

        <button onclick="handleMobileNavSwitch('riwayat', 3)" class="mobile-nav-item relative flex-1 flex flex-col items-center justify-center h-full py-1 transition group z-10" data-index="3">
          <i class="mobile-nav-icon fa-solid fa-vault text-sm text-slate-400 group-hover:text-slate-600 transition-all duration-300"></i>
          <span class="mobile-nav-label text-[9px] mt-1 transition-all duration-300 text-slate-400 font-semibold tracking-tight">Tabungan</span>
          <span class="mobile-nav-dot w-1 h-1 rounded-full bg-theme-primary mt-0.5 opacity-0 scale-0 transition-all duration-300"></span>
        </button>

        <button onclick="handleMobileNavSwitch('master', 4)" class="mobile-nav-item relative flex-1 flex flex-col items-center justify-center h-full py-1 transition group z-10" data-index="4">
          <i class="mobile-nav-icon fa-solid fa-sliders text-sm text-slate-400 group-hover:text-slate-600 transition-all duration-300"></i>
          <span class="mobile-nav-label text-[9px] mt-1 transition-all duration-300 text-slate-400 font-semibold tracking-tight">Profil</span>
          <span class="mobile-nav-dot w-1 h-1 rounded-full bg-theme-primary mt-0.5 opacity-0 scale-0 transition-all duration-300"></span>
        </button>
      </div>
    </div>

  </div>

  <!-- TOAST NOTIFICATION CONTAINER -->
  <div id="toastContainer" class="fixed top-3 right-3 z-50 flex flex-col gap-1.5 pointer-events-none max-w-xs w-full"></div>

  <!-- CUSTOM CONFIRMATION MODAL -->
  <div id="customConfirmModal" class="fixed inset-0 z-[80] bg-slate-900/60 backdrop-blur-xs flex items-center justify-center p-4 hidden">
    <div class="bg-white rounded-3xl max-w-xs w-full p-5 shadow-2xl border border-slate-200 text-center space-y-3">
      <div class="w-10 h-10 rounded-2xl bg-amber-100 text-amber-600 flex items-center justify-center mx-auto text-lg">
        <i class="fa-solid fa-triangle-exclamation"></i>
      </div>
      <h3 id="customConfirmTitle" class="text-sm font-extrabold text-slate-900">Konfirmasi Tindakan</h3>
      <p id="customConfirmMessage" class="text-xs text-slate-500">Apakah Anda yakin ingin melanjutkan tindakan ini?</p>
      <div class="flex gap-2 pt-2">
        <button id="customConfirmCancelBtn" type="button" class="flex-1 py-2 rounded-xl border border-slate-200 font-bold text-xs text-slate-600 hover:bg-slate-50">Batal</button>
        <button id="customConfirmOkBtn" type="button" class="flex-1 py-2 rounded-xl bg-rose-600 hover:bg-rose-700 text-white font-bold text-xs shadow-xs">Ya, Lanjutkan</button>
      </div>
    </div>
  </div>

  <!-- MODAL: LOGIN / REGISTER -->
  <div id="modalLoginGate" class="fixed inset-0 z-50 bg-slate-900/80 backdrop-blur-md flex items-center justify-center p-4 hidden">
    <div id="loginGateCard" class="bg-white rounded-3xl max-w-sm w-full p-6 shadow-2xl border border-slate-200 text-center relative overflow-hidden">
      <div class="w-12 h-12 rounded-2xl bg-theme-primary text-white mx-auto flex items-center justify-center text-xl shadow-md mb-2">
        <i class="fa-solid fa-vault"></i>
      </div>
      <h3 class="text-base font-black text-slate-900">KEUANGAN KELUARGA</h3>
      <p class="text-xs text-slate-400 mt-0.5">Buku Kas & Brankas Bersama Suami & Istri</p>

      <!-- Auth Tabs -->
      <div class="flex p-1 bg-slate-100 rounded-xl mt-3 text-xs font-bold">
        <button type="button" id="tabBtnLogin" onclick="switchAuthMode('login')" class="flex-1 py-1.5 rounded-lg bg-white text-slate-900 shadow-xs transition">
          Masuk (Sign In)
        </button>
        <button type="button" id="tabBtnRegister" onclick="switchAuthMode('register')" class="flex-1 py-1.5 rounded-lg text-slate-500 hover:text-slate-800 transition">
          Daftar Akun Baru
        </button>
      </div>

      <!-- Kotak Peringatan Merah Login Gagal -->
      <div id="loginErrorMessage" class="hidden mt-3 p-2.5 rounded-xl bg-rose-50 border border-rose-200 text-rose-600 text-[11px] font-bold flex items-center gap-2 text-left">
        <i class="fa-solid fa-circle-exclamation shrink-0"></i>
        <span id="loginErrorText">ID Pengguna atau Kata Sandi salah!</span>
      </div>

      <!-- Auth Form -->
      <form onsubmit="handleAuthSubmit(event)" class="mt-3 space-y-3 text-left text-xs">
        <div id="registerFieldFullName" class="hidden">
          <label class="block font-bold text-slate-700 mb-1">Nama Lengkap</label>
          <input id="authFullName" type="text" oninput="hideLoginError()" placeholder="Contoh: Bagus Pratama" class="w-full px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl font-bold text-slate-800 focus-theme-ring">
        </div>

        <div id="registerFieldRole" class="hidden">
          <label class="block font-bold text-slate-700 mb-1">Peran Anggota</label>
          <select id="authRoleSelect" class="w-full px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl font-bold text-slate-800 focus-theme-ring">
            <option value="Suami">Suami (Akses Penuh Master)</option>
            <option value="Istri">Istri (Akses Catat & Riwayat)</option>
          </select>
        </div>

        <div>
          <label class="block font-bold text-slate-700 mb-1">ID Pengguna (Username)</label>
          <input id="loginUsername" type="text" oninput="hideLoginError()" placeholder="Masukkan ID/Username..." required class="w-full px-3.5 py-2 bg-slate-50 border border-slate-200 rounded-xl font-bold text-slate-800 focus-theme-ring">
        </div>

        <div>
          <label class="block font-bold text-slate-700 mb-1">Kata Sandi (Password)</label>
          <div class="relative">
            <input id="loginPassword" type="password" oninput="hideLoginError()" placeholder="Masukkan kata sandi..." required class="w-full pl-3.5 pr-9 py-2 bg-slate-50 border border-slate-200 rounded-xl font-bold text-slate-800 focus-theme-ring">
            <button type="button" onclick="togglePasswordVisibility('loginPassword', 'eyeIconLogin')" class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600 focus:outline-none p-1">
              <i id="eyeIconLogin" class="fa-solid fa-eye text-xs"></i>
            </button>
          </div>
        </div>

        <button type="submit" id="authSubmitBtn" class="w-full py-2.5 rounded-xl bg-theme-primary font-bold text-white shadow-xs hover:opacity-95 transition mt-2 flex items-center justify-center gap-1.5">
          <i class="fa-solid fa-right-to-bracket"></i>
          <span>Masuk Sekarang</span>
        </button>
      </form>
    </div>
  </div>

  <!-- MODAL: Tambah Pemasukan -->
  <div id="modalAddIncome" class="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-center justify-center p-4 hidden">
    <div class="bg-white rounded-3xl max-w-sm w-full p-5 shadow-2xl border border-slate-200 max-h-[90vh] overflow-y-auto">
      <div class="flex items-center justify-between pb-2.5 border-b border-slate-100">
        <div class="flex items-center gap-2">
          <div class="w-7 h-7 rounded-lg bg-emerald-100 text-emerald-600 flex items-center justify-center font-bold text-xs">
            <i class="fa-solid fa-circle-plus"></i>
          </div>
          <h3 class="text-sm font-black text-slate-900">Tambah Pemasukan</h3>
        </div>
        <button onclick="closeModal('modalAddIncome')" class="w-6 h-6 rounded-full bg-slate-100 text-slate-400 hover:text-slate-700 flex items-center justify-center text-xs">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>

      <form onsubmit="handleSaveIncome(event)" class="mt-3 space-y-3 text-xs">
        <div>
          <label class="block font-bold text-slate-700 mb-1">Pos Pemasukan</label>
          <div class="grid grid-cols-2 gap-2">
            <label class="flex items-center gap-1.5 p-2 rounded-xl border border-slate-200 cursor-pointer has-[:checked]:border-emerald-500 has-[:checked]:bg-emerald-50">
              <input type="radio" name="income_type" value="gaji" class="text-emerald-600" checked>
              <span class="font-bold text-slate-800 text-[11px]">Gaji Pokok</span>
            </label>
            <label class="flex items-center gap-1.5 p-2 rounded-xl border border-slate-200 cursor-pointer has-[:checked]:border-emerald-500 has-[:checked]:bg-emerald-50">
              <input type="radio" name="income_type" value="non_gaji" class="text-emerald-600">
              <span class="font-bold text-slate-800 text-[11px]">Non-Gaji</span>
            </label>
          </div>
        </div>

        <div>
          <label class="block font-bold text-slate-700 mb-1">Kategori Pemasukan</label>
          <select id="incomeCategorySelect" class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl font-semibold text-slate-800 focus-theme-ring text-xs"></select>
        </div>

        <div>
          <label class="block font-bold text-slate-700 mb-1">Nominal (Rp) *</label>
          <input id="inputIncomeAmount" type="number" step="1000" min="1000" placeholder="Contoh: 5000000" required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl font-bold font-mono-num text-slate-800 text-xs focus-theme-ring">
        </div>

        <div>
          <label class="block font-bold text-slate-700 mb-1">Tanggal</label>
          <input id="inputIncomeDate" type="date" required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl font-semibold text-slate-800 text-xs">
        </div>

        <div>
          <label class="block font-bold text-slate-700 mb-1">Catatan / Sumber</label>
          <input id="inputIncomeNotes" type="text" placeholder="Catatan opsional..." class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 text-xs">
        </div>

        <!-- Receipt upload directly to Supabase Storage -->
        <div>
          <label class="block font-bold text-slate-700 mb-1">Lampirkan Bukti / Nota (Supabase Cloud Storage)</label>
          <input type="file" id="inputIncomeReceiptFile" accept="image/*" onchange="handleReceiptFileSelection(event, 'income')" class="w-full text-[11px] text-slate-500 file:mr-2 file:py-1 file:px-2.5 file:rounded-xl file:border-0 file:text-[10px] file:font-bold file:bg-slate-100 file:text-slate-700">
          <div id="previewIncomePhotoWrapper" class="mt-1 hidden relative w-16 h-16 rounded-xl overflow-hidden border border-slate-200">
            <img id="previewIncomePhoto" class="w-full h-full object-cover">
            <button type="button" onclick="removeSelectedReceiptFile('income')" class="absolute top-0.5 right-0.5 w-4 h-4 rounded-full bg-rose-600 text-white flex items-center justify-center text-[9px]"><i class="fa-solid fa-xmark"></i></button>
          </div>
        </div>

        <div class="flex gap-2 pt-2">
          <button type="button" onclick="closeModal('modalAddIncome')" class="flex-1 py-2 rounded-xl border border-slate-200 font-bold text-slate-600">Batal</button>
          <button type="submit" id="btnSubmitIncome" class="flex-1 py-2 rounded-xl bg-emerald-600 hover:bg-emerald-700 font-bold text-white shadow-xs">Simpan</button>
        </div>
      </form>
    </div>
  </div>

  <!-- MODAL: Tambah Pengeluaran -->
  <div id="modalAddExpense" class="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-center justify-center p-4 hidden">
    <div class="bg-white rounded-3xl max-w-sm w-full p-5 shadow-2xl border border-slate-200 max-h-[90vh] overflow-y-auto">
      <div class="flex items-center justify-between pb-2.5 border-b border-slate-100">
        <div class="flex items-center gap-2">
          <div class="w-7 h-7 rounded-lg bg-orange-100 text-[#F97316] flex items-center justify-center font-bold text-xs">
            <i class="fa-solid fa-circle-minus"></i>
          </div>
          <h3 class="text-sm font-black text-slate-900">Tambah Pengeluaran</h3>
        </div>
        <button onclick="closeModal('modalAddExpense')" class="w-6 h-6 rounded-full bg-slate-100 text-slate-400 hover:text-slate-700 flex items-center justify-center text-xs">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>

      <form onsubmit="handleSaveExpense(event)" class="mt-3 space-y-3 text-xs">
        <div>
          <label class="block font-bold text-slate-700 mb-1">Kategori Pengeluaran *</label>
          <select id="expenseCategorySelect" required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl font-semibold text-slate-800 focus-theme-ring text-xs"></select>
        </div>

        <div>
          <label class="block font-bold text-slate-700 mb-1">Nominal (Rp) *</label>
          <input id="inputExpenseAmount" type="number" step="1000" min="500" placeholder="Contoh: 150000" required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl font-bold font-mono-num text-slate-800 text-xs focus-theme-ring">
        </div>

        <div>
          <label class="block font-bold text-slate-700 mb-1">Tanggal</label>
          <input id="inputExpenseDate" type="date" required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl font-semibold text-slate-800 text-xs">
        </div>

        <div>
          <label class="block font-bold text-slate-700 mb-1">Keperluan / Keterangan</label>
          <input id="inputExpenseNotes" type="text" placeholder="Keperluan belanja..." class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 text-xs">
        </div>

        <!-- Receipt upload directly to Supabase Storage -->
        <div>
          <label class="block font-bold text-slate-700 mb-1">Lampirkan Struk / Nota (Supabase Cloud Storage)</label>
          <input type="file" id="inputExpenseReceiptFile" accept="image/*" onchange="handleReceiptFileSelection(event, 'expense')" class="w-full text-[11px] text-slate-500 file:mr-2 file:py-1 file:px-2.5 file:rounded-xl file:border-0 file:text-[10px] file:font-bold file:bg-slate-100 file:text-slate-700">
          <div id="previewExpensePhotoWrapper" class="mt-1 hidden relative w-16 h-16 rounded-xl overflow-hidden border border-slate-200">
            <img id="previewExpensePhoto" class="w-full h-full object-cover">
            <button type="button" onclick="removeSelectedReceiptFile('expense')" class="absolute top-0.5 right-0.5 w-4 h-4 rounded-full bg-rose-600 text-white flex items-center justify-center text-[9px]"><i class="fa-solid fa-xmark"></i></button>
          </div>
        </div>

        <div class="flex gap-2 pt-2">
          <button type="button" onclick="closeModal('modalAddExpense')" class="flex-1 py-2 rounded-xl border border-slate-200 font-bold text-slate-600">Batal</button>
          <button type="submit" id="btnSubmitExpense" class="flex-1 py-2 rounded-xl bg-[#F97316] hover:bg-orange-600 font-bold text-white shadow-xs">Simpan</button>
        </div>
      </form>
    </div>
  </div>

  <!-- MODAL: Tarik Tabungan ke Pemasukan -->
  <div id="modalTarikTabungan" class="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-center justify-center p-4 hidden">
    <div class="bg-white rounded-3xl max-w-sm w-full p-5 shadow-2xl border border-slate-200">
      <div class="flex items-center justify-between pb-2 border-b border-slate-100">
        <h3 class="text-sm font-black text-slate-900">Tarik Tabungan ke Kas</h3>
        <button onclick="closeModal('modalTarikTabungan')" class="w-6 h-6 rounded-full bg-slate-100 text-slate-400">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
      <form onsubmit="handleTarikTabunganSubmit(event)" class="mt-3 space-y-3 text-xs">
        <div>
          <label class="block font-bold text-slate-700 mb-1">Nominal Tarik (Rp)</label>
          <input id="inputTarikAmount" type="number" step="1000" min="1000" required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl font-bold font-mono-num text-slate-800 text-xs focus-theme-ring">
        </div>
        <div>
          <label class="block font-bold text-slate-700 mb-1">Keperluan / Keterangan</label>
          <input id="inputTarikNotes" type="text" placeholder="Misal: Biaya darurat renovasi..." required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl text-slate-800 text-xs">
        </div>
        <div class="flex gap-2 pt-1">
          <button type="button" onclick="closeModal('modalTarikTabungan')" class="flex-1 py-2 rounded-xl border border-slate-200 font-bold text-slate-600">Batal</button>
          <button type="submit" class="flex-1 py-2 rounded-xl bg-amber-500 font-bold text-slate-950">Tarik Sekarang</button>
        </div>
      </form>
    </div>
  </div>

  <!-- MODAL: Buku Detail Transaksi (ON-DEMAND RECEIPT FETCH TO SAVE EGRESS) -->
  <div id="modalBukuDetail" class="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-center justify-center p-4 hidden">
    <div class="bg-white rounded-3xl max-w-sm w-full p-5 shadow-2xl border border-slate-200 text-xs space-y-3">
      <div class="flex items-center justify-between pb-2 border-b border-slate-100">
        <h3 class="text-sm font-black text-slate-900">Rincian Transaksi</h3>
        <button onclick="closeModal('modalBukuDetail')" class="w-6 h-6 rounded-full bg-slate-100 text-slate-400">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>

      <div class="space-y-2">
        <div class="flex justify-between text-slate-500">
          <span>Tanggal:</span>
          <strong id="detailTransDate" class="text-slate-800 font-mono-num">-</strong>
        </div>
        <div class="flex justify-between text-slate-500">
          <span>Pos / Kategori:</span>
          <strong id="detailTransCat" class="text-slate-800">-</strong>
        </div>
        <div class="flex justify-between text-slate-500">
          <span>Dicatat Oleh:</span>
          <span id="detailTransAuthor" class="px-2 py-0.5 rounded-full font-bold bg-blue-50 text-blue-700">-</span>
        </div>
        <div class="flex justify-between text-slate-500">
          <span>Nominal:</span>
          <strong id="detailTransAmount" class="font-mono-num text-sm text-slate-900">-</strong>
        </div>
        <div class="border-t border-slate-100 pt-2">
          <span class="text-slate-400 text-[10px] block">Catatan / Keperluan:</span>
          <p id="detailTransNotes" class="font-medium text-slate-800 text-xs mt-0.5">-</p>
        </div>
        
        <!-- On-Demand Receipt Section with Egress Optimization -->
        <div id="detailTransPhotoSection" class="hidden border-t border-slate-100 pt-2">
          <div class="flex items-center justify-between mb-1">
            <span class="text-slate-400 text-[10px] block">Bukti Foto / Nota (Supabase Storage):</span>
            <span class="text-[9px] text-emerald-600 font-bold bg-emerald-50 px-1.5 py-0.2 rounded">On-Demand Egress</span>
          </div>
          <!-- Loading skeleton while downloading -->
          <div id="detailTransPhotoLoading" class="w-full h-36 bg-slate-100 rounded-xl flex items-center justify-center text-slate-400 animate-pulse text-[11px] font-semibold gap-1.5">
            <i class="fa-solid fa-circle-notch fa-spin text-sky-500"></i>
            <span>Memuat foto nota...</span>
          </div>
          <img id="detailTransPhoto" class="hidden w-full max-h-48 rounded-xl object-contain border border-slate-200 bg-slate-50">
        </div>
      </div>

      <div class="flex gap-2 pt-2 border-t border-slate-100">
        <button type="button" onclick="closeModal('modalBukuDetail')" class="flex-1 py-2 rounded-xl border border-slate-200 font-bold text-slate-600">Tutup</button>
        <button type="button" onclick="executeDeleteFromBukuDetail()" class="px-4 py-2 rounded-xl bg-rose-600 text-white font-bold hover:bg-rose-700 flex items-center gap-1">
          <i class="fa-regular fa-trash-can"></i>
          <span>Hapus</span>
        </button>
      </div>
    </div>
  </div>

  <!-- MODAL: Edit Profil & Kredensial Login -->
  <div id="modalEditProfile" class="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-center justify-center p-4 hidden">
    <div class="bg-white rounded-3xl max-w-sm w-full p-5 shadow-2xl border border-slate-200">
      <div class="flex items-center justify-between pb-2 border-b border-slate-100">
        <h3 id="modalEditProfileTitle" class="text-sm font-black text-slate-900">Ubah Akun & Sandi</h3>
        <button onclick="closeModal('modalEditProfile')" class="w-6 h-6 rounded-full bg-slate-100 text-slate-400">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
      <form onsubmit="handleSaveProfile(event)" class="mt-3 space-y-2.5 text-xs">
        <input type="hidden" id="editProfileRole">
        <div>
          <label class="block font-bold text-slate-700 mb-1">Nama Lengkap</label>
          <input id="inputEditProfileName" type="text" required class="w-full px-3 py-1.5 bg-slate-50 border border-slate-200 rounded-xl font-bold text-slate-800">
        </div>
        <div>
          <label class="block font-bold text-slate-700 mb-1">ID Pengguna (Username Login)</label>
          <input id="inputEditProfileUsername" type="text" required class="w-full px-3 py-1.5 bg-slate-50 border border-slate-200 rounded-xl font-bold text-slate-800">
        </div>
        <div>
          <label class="block font-bold text-slate-700 mb-1">Kata Sandi Baru</label>
          <input id="inputEditProfilePassword" type="password" required class="w-full px-3 py-1.5 bg-slate-50 border border-slate-200 rounded-xl font-bold text-slate-800">
        </div>
        <div>
          <label class="block font-bold text-slate-700 mb-1">URL Foto Profil</label>
          <input id="inputEditProfileAvatar" type="url" required class="w-full px-3 py-1.5 bg-slate-50 border border-slate-200 rounded-xl font-mono text-slate-800 text-[11px]">
        </div>
        <div class="flex gap-2 pt-2">
          <button type="button" onclick="closeModal('modalEditProfile')" class="flex-1 py-2 rounded-xl border border-slate-200 font-bold text-slate-600">Batal</button>
          <button type="submit" class="flex-1 py-2 rounded-xl bg-theme-primary text-white font-bold">Simpan</button>
        </div>
      </form>
    </div>
  </div>

  <!-- MODAL: Tambah Kategori -->
  <div id="modalAddCategory" class="fixed inset-0 z-50 bg-slate-900/50 backdrop-blur-xs flex items-center justify-center p-4 hidden">
    <div class="bg-white rounded-3xl max-w-sm w-full p-5 shadow-2xl border border-slate-200">
      <div class="flex items-center justify-between pb-2 border-b border-slate-100">
        <h3 class="text-sm font-black text-slate-900">Tambah Kategori Master</h3>
        <button onclick="closeModal('modalAddCategory')" class="w-6 h-6 rounded-full bg-slate-100 text-slate-400">
          <i class="fa-solid fa-xmark"></i>
        </button>
      </div>
      <form onsubmit="handleSaveCategory(event)" class="mt-3 space-y-3 text-xs">
        <div>
          <label class="block font-bold text-slate-700 mb-1">Nama Kategori</label>
          <input id="inputCategoryName" type="text" placeholder="Nama kategori..." required class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl font-bold text-slate-800">
        </div>
        <div>
          <label class="block font-bold text-slate-700 mb-1">Tipe Pos</label>
          <select id="inputCategoryType" class="w-full px-3 py-2 bg-slate-50 border border-slate-200 rounded-xl font-bold text-slate-800">
            <option value="expense">Pengeluaran</option>
            <option value="income">Pemasukan</option>
          </select>
        </div>
        <div class="flex gap-2 pt-1">
          <button type="button" onclick="closeModal('modalAddCategory')" class="flex-1 py-2 rounded-xl border border-slate-200 font-bold text-slate-600">Batal</button>
          <button type="submit" class="flex-1 py-2 rounded-xl bg-slate-900 text-white font-bold">Simpan</button>
        </div>
      </form>
    </div>
  </div>

  <script>
    /* ==========================================================================
       1. PROTEKSI CORS PROTOKOL FILE:/// (PWA MANIFEST & SERVICE WORKER)
       ========================================================================== */
    if (window.location.protocol === 'http:' || window.location.protocol === 'https:') {
      const manifestLink = document.createElement('link');
      manifestLink.rel = 'manifest';
      manifestLink.href = './manifest.json';
      document.head.appendChild(manifestLink);

      if ('serviceWorker' in navigator) {
        window.addEventListener('load', () => {
          navigator.serviceWorker.register('./sw.js').catch(err => {
            console.warn('PWA Service Worker dilewati:', err);
          });
        });
      }
    }

    /* ==========================================================================
       2. SUPABASE CONFIGURATION (Project Nyata Anda)
       ========================================================================== */
    const SUPABASE_CONFIG = {
      URL: 'https://goghrpcpkxgnperdlunv.supabase.co',
      ANON_KEY: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdvZ2hycGNwa3hnbnBlcmRsdW52Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTAwNDU5ODEsImV4cCI6MjEwNTYyMTk4MX0.o2whDFlZ-KtnNLgHUP1X9NKdimZsXlPmStmC46ATw0I'
    };

    let supabaseClient = null;
    let realtimeChannel = null;

    /* Global Application State */
    let currentAuthUser = null;
    let activeRole = 'Suami';
    let authMode = 'login';
    let currentTheme = 'sky';
    let globalCardBg = 'putih';
    let donutMode = 'expense';
    let activeDetailTransaction = null;
    
    // File upload references for Supabase Storage
    let selectedReceiptFiles = { income: null, expense: null };
    let currentMobileTabIndex = 0;

    // Palet warna otomatis yang selaras dengan tema yang dipilih
    const THEME_ACCENTS = {
      putih: { primary: '#0EA5E9', light: '#F0F9FF', dark: '#0284C7', ring: 'rgba(14, 165, 233, 0.25)' },
      biru_langit: { primary: '#0284C7', light: '#E0F2FE', dark: '#0369A1', ring: 'rgba(2, 132, 199, 0.25)' },
      pink: { primary: '#EC4899', light: '#FDF2F8', dark: '#BE185D', ring: 'rgba(236, 72, 153, 0.25)' },
      toska: { primary: '#14B8A6', light: '#CCFBF1', dark: '#0F766E', ring: 'rgba(20, 184, 166, 0.25)' },
      abu: { primary: '#64748B', light: '#F1F5F9', dark: '#475569', ring: 'rgba(100, 116, 139, 0.25)' },
      kucing: { primary: '#D97706', light: '#FEF3C7', dark: '#B45309', ring: 'rgba(217, 119, 6, 0.25)' },
      mint: { primary: '#10B981', light: '#D1FAE5', dark: '#047857', ring: 'rgba(16, 185, 129, 0.25)' },
      gelap: { primary: '#38BDF8', light: '#1E293B', dark: '#0284C7', ring: 'rgba(56, 189, 248, 0.25)' }
    };

    // Fungsi atur tema kartu: MURNI HANYA DISIMPAN DI LOKAL STORAGE PERANGKAT
    function setCardTheme(cardThemeKey, notify = true) {
      globalCardBg = cardThemeKey;
      document.body.setAttribute('data-card-theme', cardThemeKey);
      localStorage.setItem('family_finance_card_theme', cardThemeKey);

      // Aksen warna tombol & sorotan otomatis disesuaikan agar serasi dengan tema kartu
      const acc = THEME_ACCENTS[cardThemeKey] || THEME_ACCENTS.putih;
      document.documentElement.style.setProperty('--primary-color', acc.primary);
      document.documentElement.style.setProperty('--primary-light', acc.light);
      document.documentElement.style.setProperty('--primary-dark', acc.dark);
      document.documentElement.style.setProperty('--primary-ring', acc.ring);

      document.querySelectorAll('.theme-card-btn').forEach(btn => {
        if (btn.getAttribute('data-val') === cardThemeKey) {
          btn.classList.add('ring-2', 'ring-theme-primary', 'border-theme-primary');
        } else {
          btn.classList.remove('ring-2', 'ring-theme-primary', 'border-theme-primary');
        }
      });

      const readableName = {
        putih: 'Putih',
        biru_langit: 'Biru Langit',
        pink: 'Pink',
        toska: 'Toska',
        abu: 'Abu-abu',
        kucing: 'Kucing 🐾',
        mint: 'Mint',
        gelap: 'Gelap'
      }[cardThemeKey] || cardThemeKey;

      if (notify) showToast(`Tema "${readableName}" diterapkan di HP ini!`, 'info');
    }

    // Inisialisasi tema saat aplikasi pertama kali dibuka di HP ini
    function initLocalTheme() {
      let savedCard = localStorage.getItem('family_finance_card_theme') || 'putih';
      if (savedCard === 'navy') savedCard = 'biru_langit'; // Transisi aman dari tema navy yang dihapus
      setCardTheme(savedCard, false);
    }

    // Standard RFC4122 UUID generator
    function generateUUID() {
      if (typeof crypto !== 'undefined' && crypto.randomUUID) {
        return crypto.randomUUID();
      }
      return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        const r = Math.random() * 16 | 0;
        const v = c === 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
      });
    }

    // Profiles with Login Credentials
    let profiles = {
      'Suami': {
        id: '11111111-1111-1111-1111-111111111111',
        full_name: 'Bagus Pratama',
        role: 'Suami',
        username: 'bagus',
        password: '123',
        avatar_url: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=160&h=160&fit=crop&crop=faces'
      },
      'Istri': {
        id: '22222222-2222-2222-2222-222222222222',
        full_name: 'Anindya Putri',
        role: 'Istri',
        username: 'anindya',
        password: '123',
        avatar_url: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=160&h=160&fit=crop&crop=faces'
      }
    };

    // Master Categories
    let categoriesMaster = [
      { id: generateUUID(), name: 'Gaji Kantor', type: 'income', is_active: true },
      { id: generateUUID(), name: 'Bonus & THR', type: 'income', is_active: true },
      { id: generateUUID(), name: 'Usaha Sampingan', type: 'income', is_active: true },
      { id: generateUUID(), name: 'Makan & Belanja Dapur', type: 'expense', is_active: true },
      { id: generateUUID(), name: 'Listrik, Air & WiFi', type: 'expense', is_active: true },
      { id: generateUUID(), name: 'Transportasi & Bensin', type: 'expense', is_active: true },
      { id: generateUUID(), name: 'Cicilan Rumah & KPR', type: 'expense', is_active: true },
      { id: generateUUID(), name: 'Hiburan & Liburan', type: 'expense', is_active: true }
    ];

    // Murni Mengambil dari Supabase (Data Awal Bersih Rp 0)
    let incomes = [];
    let expenses = [];
    let savingsHistory = [];

    /* Chart instances */
    let lineChartInstance = null;
    let donutChartInstance = null;

    function formatIDR(value) {
      const num = Number(value) || 0;
      return 'Rp ' + num.toLocaleString('id-ID');
    }

    function formatIDRCompact(value) {
      const num = Number(value) || 0;
      if (Math.abs(num) >= 1000000) {
        const juta = (num / 1000000).toFixed(1).replace('.', ',');
        return 'Rp ' + (juta.endsWith(',0') ? juta.slice(0, -2) : juta) + ' Juta';
      }
      return 'Rp ' + num.toLocaleString('id-ID');
    }

    function showToast(message, type = 'info') {
      const container = document.getElementById('toastContainer');
      const toast = document.createElement('div');
      
      const icons = {
        success: 'fa-circle-check text-emerald-500',
        warning: 'fa-triangle-exclamation text-amber-500',
        info: 'fa-circle-info text-sky-500',
        error: 'fa-circle-xmark text-rose-500'
      };

      toast.className = 'p-2.5 rounded-xl bg-white border border-slate-200 shadow-lg flex items-center gap-2 text-xs font-semibold text-slate-800 transform transition-all duration-300 translate-y-2 opacity-0 pointer-events-auto';
      toast.innerHTML = `
        <i class="fa-solid ${icons[type] || icons.info} text-sm"></i>
        <div class="flex-1 text-[11px]">${message}</div>
        <button onclick="this.parentElement.remove()" class="text-slate-400 hover:text-slate-600"><i class="fa-solid fa-xmark"></i></button>
      `;

      container.appendChild(toast);
      requestAnimationFrame(() => toast.classList.remove('translate-y-2', 'opacity-0'));
      setTimeout(() => {
        toast.classList.add('opacity-0', 'translate-y-2');
        setTimeout(() => toast.remove(), 300);
      }, 3500);
    }

    function showConfirmModal(title, message, onConfirm) {
      const modal = document.getElementById('customConfirmModal');
      document.getElementById('customConfirmTitle').innerText = title;
      document.getElementById('customConfirmMessage').innerText = message;
      
      const okBtn = document.getElementById('customConfirmOkBtn');
      const cancelBtn = document.getElementById('customConfirmCancelBtn');

      const cleanup = () => {
        modal.classList.add('hidden');
        okBtn.onclick = null;
        cancelBtn.onclick = null;
      };

      okBtn.onclick = () => {
        cleanup();
        if (typeof onConfirm === 'function') onConfirm();
      };
      cancelBtn.onclick = () => cleanup();

      modal.classList.remove('hidden');
    }

    /* ==========================================================================
       AUTENTIKASI & PERSISTENSI LOGIN SEKALI (PERMANENT AUTO-LOGIN)
       ========================================================================== */
    function checkAuthStatus() {
      // 1. Periksa sesi lengkap yang tersimpan permanen di perangkat ini
      const savedSession = localStorage.getItem('family_finance_user_session') || localStorage.getItem('family_finance_auth');
      
      if (savedSession) {
        try {
          const authData = JSON.parse(savedSession);
          
          // Jika data sesi valid (sudah login/register sebelumnya), langsung aktifkan tanpa minta login lagi!
          if (authData && (authData.username || authData.id)) {
            const role = authData.role || 'Suami';

            // Sinkronkan objek profil aktif
            profiles[role] = {
              id: authData.id || generateUUID(),
              full_name: authData.full_name || (role === 'Suami' ? 'Bagus Pratama' : 'Anindya Putri'),
              role: role,
              username: authData.username || (role === 'Suami' ? 'bagus' : 'anindya'),
              password: authData.password || authData.password_hash || '123',
              avatar_url: authData.avatar_url || (role === 'Istri' 
                ? 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=160&h=160&fit=crop' 
                : 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=160&h=160&fit=crop')
            };

            currentAuthUser = profiles[role];
            activeRole = role;

            // Kunci modal login tetap tertutup rapat (tidak berkedip atau memunculkan bayangan)
            const gate = document.getElementById('modalLoginGate');
            if (gate) gate.classList.add('hidden');

            updateUserUI();
            return true;
          }
        } catch (e) {
          console.error("Gagal membaca sesi lokal:", e);
        }
      }

      // 2. Layar login HANYA dibuka jika belum pernah login sama sekali atau setelah menekan tombol logout
      const gate = document.getElementById('modalLoginGate');
      if (gate) gate.classList.remove('hidden');
      return false;
    }

    function hideLoginError() {
      const el = document.getElementById('loginErrorMessage');
      if (el) el.classList.add('hidden');
    }

    function togglePasswordVisibility(inputId, iconId) {
      const input = document.getElementById(inputId);
      const icon = document.getElementById(iconId);
      if (!input || !icon) return;
      if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
      } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
      }
    }

    function switchAuthMode(mode) {
      authMode = mode;
      hideLoginError();
      const btnLogin = document.getElementById('tabBtnLogin');
      const btnReg = document.getElementById('tabBtnRegister');
      const fnField = document.getElementById('registerFieldFullName');
      const roleField = document.getElementById('registerFieldRole');
      const submitBtn = document.getElementById('authSubmitBtn');

      if (mode === 'register') {
        btnLogin.className = "flex-1 py-1.5 rounded-lg text-slate-500 hover:text-slate-800 transition";
        btnReg.className = "flex-1 py-1.5 rounded-lg bg-white text-slate-900 shadow-xs transition";
        fnField.classList.remove('hidden');
        roleField.classList.remove('hidden');
        submitBtn.innerHTML = '<i class="fa-solid fa-user-plus mr-1"></i> Daftar Sekarang';
      } else {
        btnReg.className = "flex-1 py-1.5 rounded-lg text-slate-500 hover:text-slate-800 transition";
        btnLogin.className = "flex-1 py-1.5 rounded-lg bg-white text-slate-900 shadow-xs transition";
        fnField.classList.add('hidden');
        roleField.classList.add('hidden');
        submitBtn.innerHTML = '<i class="fa-solid fa-right-to-bracket mr-1"></i> Masuk Sekarang';
      }
    }

    async function handleAuthSubmit(e) {
      e.preventDefault();
      const u = document.getElementById('loginUsername').value.trim().toLowerCase();
      const p = document.getElementById('loginPassword').value.trim();

      if (authMode === 'register') {
        const fullName = document.getElementById('authFullName').value.trim();
        const role = document.getElementById('authRoleSelect').value;

        if (!fullName || !u || !p) {
          showToast('Lengkapi nama, username, dan kata sandi!', 'warning');
          return;
        }

        const newProfile = {
          id: generateUUID(),
          full_name: fullName,
          role: role,
          username: u,
          password: p,
          avatar_url: role === 'Istri' 
            ? 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=160&h=160&fit=crop' 
            : 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=160&h=160&fit=crop'
        };

        profiles[role] = newProfile;
        currentAuthUser = newProfile;
        activeRole = role;

        // SIMPAN DATA LENGKAP KE LOCAL STORAGE AGAR LOGIN HANYA SEKALI & PERMANEN
        localStorage.setItem('family_finance_user_session', JSON.stringify(newProfile));
        localStorage.setItem('family_finance_auth', JSON.stringify({ username: u }));

        if (supabaseClient) {
          try {
            await supabaseClient.from('profiles').insert({
              id: newProfile.id,
              full_name: newProfile.full_name,
              role: newProfile.role,
              username: newProfile.username,
              password_hash: newProfile.password,
              avatar_url: newProfile.avatar_url
            });
          } catch (err) {
            console.warn("Supabase register push:", err);
          }
        }

        document.getElementById('modalLoginGate').classList.add('hidden');
        updateUserUI();
        updateDashboardMetrics();
        showToast(`Akun ${fullName} (${role}) berhasil didaftarkan! Sesi Anda disimpan permanen.`, 'success');

      } else {
        let matched = Object.values(profiles).find(
          prof => prof.username.toLowerCase() === u && prof.password === p
        );

        if (!matched && supabaseClient) {
          try {
            const { data } = await supabaseClient.from('profiles').select('*').eq('username', u).maybeSingle();
            if (data && (data.password_hash === p || data.password === p)) {
              matched = {
                id: data.id,
                full_name: data.full_name,
                role: data.role,
                username: data.username,
                password: data.password_hash || data.password,
                avatar_url: data.avatar_url
              };
              profiles[data.role] = matched;
            }
          } catch (err) {
            console.warn("Remote auth check error:", err);
          }
        }

        if (!matched) {
          const errBox = document.getElementById('loginErrorMessage');
          const errTxt = document.getElementById('loginErrorText');
          if (errBox && errTxt) {
            errTxt.innerText = 'ID Pengguna atau Kata Sandi salah!';
            errBox.classList.remove('hidden');
          }
          showToast('ID Pengguna atau Kata Sandi salah!', 'error');
          return;
        }

        hideLoginError();
        currentAuthUser = matched;
        activeRole = matched.role;

        // SIMPAN DATA LENGKAP KE LOCAL STORAGE AGAR LOGIN HANYA SEKALI & PERMANEN
        localStorage.setItem('family_finance_user_session', JSON.stringify(matched));
        localStorage.setItem('family_finance_auth', JSON.stringify({ username: matched.username }));

        document.getElementById('modalLoginGate').classList.add('hidden');
        updateUserUI();
        updateDashboardMetrics();
        showToast(`Selamat datang kembali, ${matched.full_name}!`, 'success');
      }
    }

    function handleLogout() {
      showConfirmModal(
        'Keluar dari Akun',
        'Apakah Anda yakin ingin keluar dari akun ini? Anda harus memasukkan ID dan kata sandi kembali untuk masuk.',
        () => {
          // Hapus semua token sesi login dari perangkat ini
          localStorage.removeItem('family_finance_user_session');
          localStorage.removeItem('family_finance_auth');
          currentAuthUser = null;

          // Kosongkan form login
          const uInput = document.getElementById('loginUsername');
          const pInput = document.getElementById('loginPassword');
          if (uInput) uInput.value = '';
          if (pInput) pInput.value = '';
          hideLoginError();

          // Tampilkan layar login
          const gate = document.getElementById('modalLoginGate');
          if (gate) gate.classList.remove('hidden');
          
          showToast('Anda telah keluar dari aplikasi.', 'info');
        }
      );
    }

    // Logika Siklus Gajian (Tgl 10 s/d 9 Bulan Berikutnya)
    function getPaydayCycleRange(targetDate = new Date()) {
      const year = targetDate.getFullYear();
      const month = targetDate.getMonth();
      const day = targetDate.getDate();

      let cycleStart, cycleEnd;
      if (day >= 10) {
        cycleStart = new Date(year, month, 10);
        cycleEnd = new Date(year, month + 1, 9, 23, 59, 59);
      } else {
        cycleStart = new Date(year, month - 1, 10);
        cycleEnd = new Date(year, month, 9, 23, 59, 59);
      }
      return {
        startDateStr: cycleStart.toISOString().slice(0, 10),
        endDateStr: cycleEnd.toISOString().slice(0, 10),
        cycleKey: `${cycleStart.getFullYear()}-${String(cycleStart.getMonth() + 1).padStart(2, '0')}`
      };
    }

    // Eksekusi Tutup Buku Otomatis Saat Tgl 10 (Hari Gajian)
    async function checkAndExecuteAutoTutupBuku() {
      const today = new Date();
      if (today.getDate() !== 10) return;

      const prevMonthDate = new Date(today.getFullYear(), today.getMonth() - 1, 10);
      const prevCycleKey = `${prevMonthDate.getFullYear()}-${String(prevMonthDate.getMonth() + 1).padStart(2, '0')}`;
      
      const alreadySaved = savingsHistory.some(s => s.period_month && s.period_month.includes(prevCycleKey));
      if (alreadySaved) return;

      const startPrev = new Date(today.getFullYear(), today.getMonth() - 1, 10).toISOString().slice(0, 10);
      const endPrev = new Date(today.getFullYear(), today.getMonth(), 9).toISOString().slice(0, 10);

      const cycleIncomes = incomes.filter(i => i.transaction_date >= startPrev && i.transaction_date <= endPrev);
      const cycleExpenses = expenses.filter(e => e.transaction_date >= startPrev && e.transaction_date <= endPrev);

      const totalInc = cycleIncomes.reduce((s, i) => s + Number(i.amount), 0);
      const totalExp = cycleExpenses.reduce((s, e) => s + Number(e.amount), 0);
      const surplus = totalInc - totalExp;

      if (surplus > 0) {
        const autoSav = {
          id: generateUUID(),
          period_month: `Surplus Gajian Tgl 10 (${prevCycleKey})`,
          amount_saved: surplus,
          notes: `Otomatis ditabung saat gajian tgl 10 (Periode ${startPrev} s/d ${endPrev})`,
          is_deduction: false,
          created_at: new Date().toISOString()
        };

        savingsHistory.unshift(autoSav);
        updateDashboardMetrics();
        renderSavingsHistory();
        showToast(`🎉 Hari Gajian! Surplus ${formatIDR(surplus)} otomatis dipindahkan ke Brankas Tabungan.`, 'success');

        if (supabaseClient) {
          try {
            await supabaseClient.from('savings_history').insert(autoSav);
          } catch (err) {
            console.warn("Auto tutup buku insert error:", err);
          }
        }
      }
    }

    function applyDashboardFilter() {
      updateDashboardMetrics();
    }

    function resetDashboardFilter() {
      document.getElementById('dashSearchText').value = '';
      document.getElementById('dashStartDate').value = '';
      document.getElementById('dashEndDate').value = '';
      updateDashboardMetrics();
    }

    function getFilteredDashboardTransactions() {
      const search = (document.getElementById('dashSearchText')?.value || '').toLowerCase();
      const startDate = document.getElementById('dashStartDate')?.value || '';
      const endDate = document.getElementById('dashEndDate')?.value || '';

      const filterFn = (item) => {
        const itemDate = item.transaction_date;
        const readableType = item.income_type === 'gaji' ? 'gaji pokok' : (item.income_type === 'tarik_tabungan' ? 'tarik tabungan' : 'non-gaji');
        const matchSearch = (item.notes || '').toLowerCase().includes(search) || 
                            (item.category_name || '').toLowerCase().includes(search) ||
                            (item.author_name || '').toLowerCase().includes(search) ||
                            readableType.includes(search);
        const matchStart = !startDate || itemDate >= startDate;
        const matchEnd = !endDate || itemDate <= endDate;
        return matchSearch && matchStart && matchEnd;
      };

      return {
        filteredIncomes: incomes.filter(filterFn),
        filteredExpenses: expenses.filter(filterFn)
      };
    }

    function updateDashboardMetrics() {
      const { filteredIncomes, filteredExpenses } = getFilteredDashboardTransactions();

      const gajiTotal = filteredIncomes
        .filter(i => i.income_type === 'gaji')
        .reduce((sum, i) => sum + Number(i.amount), 0);

      const nonGajiTotal = filteredIncomes
        .filter(i => i.income_type !== 'gaji')
        .reduce((sum, i) => sum + Number(i.amount), 0);

      const pengeluaranTotal = filteredExpenses
        .reduce((sum, e) => sum + Number(e.amount), 0);

      const totalIncome = gajiTotal + nonGajiTotal;
      const sisaSaldo = totalIncome - pengeluaranTotal;

      const tabunganTotal = savingsHistory
        .reduce((sum, s) => sum + (s.is_deduction ? -Number(s.amount_saved) : Number(s.amount_saved)), 0);

      document.getElementById('summarySaldo').innerText = formatIDR(sisaSaldo);
      document.getElementById('summaryGaji').innerText = formatIDRCompact(gajiTotal);
      document.getElementById('summaryNonGaji').innerText = formatIDRCompact(nonGajiTotal);
      document.getElementById('summaryPengeluaran').innerText = formatIDRCompact(pengeluaranTotal);
      document.getElementById('summaryExpenseCount').innerText = filteredExpenses.length;

      const riwayatTabunganEl = document.getElementById('riwayatTabunganBesar');
      if (riwayatTabunganEl) riwayatTabunganEl.innerText = formatIDR(tabunganTotal);

      const saldoStatusEl = document.getElementById('summarySaldoStatus');
      if (sisaSaldo < 0) {
        saldoStatusEl.className = "inline-flex items-center gap-1.5 px-3 py-1 rounded-xl text-xs font-extrabold bg-rose-500/20 text-rose-300 border border-rose-500/30";
        saldoStatusEl.innerHTML = '<i class="fa-solid fa-triangle-exclamation"></i> Defisit Kas!';
      } else {
        saldoStatusEl.className = "inline-flex items-center gap-1.5 px-3 py-1 rounded-xl text-xs font-extrabold bg-emerald-500/20 text-emerald-300 border border-emerald-500/30";
        saldoStatusEl.innerHTML = '<i class="fa-solid fa-shield-check"></i> Aman & Terkendali';
      }

      const suamiCount = [...incomes, ...expenses].filter(x => x.author_role === 'Suami').length;
      const istriCount = [...incomes, ...expenses].filter(x => x.author_role === 'Istri').length;
      document.getElementById('statsInputSuami').innerText = `${suamiCount} kali`;
      document.getElementById('statsInputIstri').innerText = `${istriCount} kali`;

      renderDualMiniTables(filteredIncomes, filteredExpenses);
      initLineChart(filteredExpenses);
      initDonutChart(filteredIncomes, filteredExpenses);
    }

    function renderDualMiniTables(incomeList, expenseList) {
      const incTbody = document.getElementById('dashIncomeMiniTable');
      const recentInc = [...incomeList].slice(0, 5);
      if (recentInc.length === 0) {
        incTbody.innerHTML = '<tr><td colspan="4" class="py-3 text-center text-slate-400 text-[9px]">Tidak ada data pemasukan.</td></tr>';
      } else {
        incTbody.innerHTML = recentInc.map(i => `
          <tr onclick="openBukuDetailModal('${i.id}', 'income')" class="hover:bg-slate-50 transition cursor-pointer">
            <td class="py-1.5 px-2 font-mono-num text-slate-500">${i.transaction_date.slice(5)}</td>
            <td class="py-1.5 px-2 font-semibold text-slate-800 truncate max-w-[85px]">${i.category_name}</td>
            <td class="py-1.5 px-2">
              <span class="px-1 py-0.2 rounded text-[8px] font-bold ${i.author_role === 'Suami' ? 'bg-blue-100 text-blue-700' : 'bg-rose-100 text-rose-700'}">${i.author_role}</span>
            </td>
            <td class="py-1.5 px-2 text-right font-bold font-mono-num text-emerald-600">+${formatIDR(i.amount)}</td>
          </tr>
        `).join('');
      }

      const expTbody = document.getElementById('dashExpenseMiniTable');
      const recentExp = [...expenseList].slice(0, 5);
      if (recentExp.length === 0) {
        expTbody.innerHTML = '<tr><td colspan="4" class="py-3 text-center text-slate-400 text-[9px]">Tidak ada data pengeluaran.</td></tr>';
      } else {
        expTbody.innerHTML = recentExp.map(e => `
          <tr onclick="openBukuDetailModal('${e.id}', 'expense')" class="hover:bg-slate-50 transition cursor-pointer">
            <td class="py-1.5 px-2 font-mono-num text-slate-500">${e.transaction_date.slice(5)}</td>
            <td class="py-1.5 px-2 font-semibold text-slate-800 truncate max-w-[85px]">${e.category_name}</td>
            <td class="py-1.5 px-2">
              <span class="px-1 py-0.2 rounded text-[8px] font-bold ${e.author_role === 'Suami' ? 'bg-blue-100 text-blue-700' : 'bg-rose-100 text-rose-700'}">${e.author_role}</span>
            </td>
            <td class="py-1.5 px-2 text-right font-bold font-mono-num text-orange-600">-${formatIDR(e.amount)}</td>
          </tr>
        `).join('');
      }
    }

    function initLineChart(targetExpenses = expenses) {
      const canvas = document.getElementById('expenseLineChart');
      if (!canvas) return;
      const ctx = canvas.getContext('2d');
      if (lineChartInstance) lineChartInstance.destroy();

      const daysInMonth = 30;
      const dailyExpenses = new Array(daysInMonth).fill(0);

      targetExpenses.forEach(e => {
        const d = new Date(e.transaction_date).getDate();
        if (d >= 1 && d <= daysInMonth) {
          dailyExpenses[d - 1] += Number(e.amount);
        }
      });

      let maxVal = Math.max(...dailyExpenses);
      let maxDay = dailyExpenses.indexOf(maxVal) + 1;
      document.getElementById('peakExpenseLabel').innerText = maxVal > 0 
        ? `Puncak: Tgl ${maxDay} (${formatIDR(maxVal)})` 
        : 'Puncak: Rp 0';

      const gradient = ctx.createLinearGradient(0, 0, 0, 180);
      gradient.addColorStop(0, 'rgba(249, 115, 22, 0.3)');
      gradient.addColorStop(1, 'rgba(249, 115, 22, 0.0)');

      lineChartInstance = new Chart(ctx, {
        type: 'line',
        data: {
          labels: Array.from({ length: daysInMonth }, (_, i) => `${i + 1}`),
          datasets: [{
            label: 'Beban Harian',
            data: dailyExpenses,
            borderColor: '#F97316',
            borderWidth: 2,
            fill: true,
            backgroundColor: gradient,
            tension: 0.35,
            pointRadius: (ctx) => (ctx.raw === maxVal && maxVal > 0 ? 5 : 2),
            pointBackgroundColor: (ctx) => (ctx.raw === maxVal && maxVal > 0 ? '#EF4444' : '#F97316')
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: { legend: { display: false } },
          scales: {
            x: { grid: { display: false }, ticks: { font: { size: 9 } } },
            y: {
              grid: { color: '#F1F5F9' },
              ticks: {
                font: { size: 9 },
                callback: (v) => v >= 1000000 ? `${(v/1000000).toFixed(1)}jt` : `${v/1000}k`
              }
            }
          }
        }
      });
    }

    function initDonutChart(targetIncomes = incomes, targetExpenses = expenses) {
      const canvas = document.getElementById('categoryDonutChart');
      if (!canvas) return;
      const ctx = canvas.getContext('2d');
      if (donutChartInstance) donutChartInstance.destroy();

      let labels = [];
      let data = [];
      let colors = ['#0EA5E9', '#F97316', '#10B981', '#F43F5E', '#8B5CF6', '#F59E0B', '#06B6D4'];
      let total = 0;

      if (donutMode === 'expense') {
        const catMap = {};
        targetExpenses.forEach(e => {
          catMap[e.category_name] = (catMap[e.category_name] || 0) + Number(e.amount);
          total += Number(e.amount);
        });
        labels = Object.keys(catMap);
        data = Object.values(catMap);
        if (labels.length === 0) {
          labels = ['Belum ada data'];
          data = [1];
          colors = ['#E2E8F0'];
        }
      } else {
        const incMap = { 'Gaji Pokok': 0, 'Non-Gaji': 0, 'Ambil Tabungan': 0 };
        targetIncomes.forEach(i => {
          if (i.income_type === 'gaji') incMap['Gaji Pokok'] += Number(i.amount);
          else if (i.income_type === 'tarik_tabungan') incMap['Ambil Tabungan'] += Number(i.amount);
          else incMap['Non-Gaji'] += Number(i.amount);
          total += Number(i.amount);
        });
        labels = Object.keys(incMap);
        data = Object.values(incMap);
        colors = ['#22C55E', '#0EA5E9', '#F59E0B'];
      }

      document.getElementById('donutCenterTotal').innerText = formatIDR(total);

      donutChartInstance = new Chart(ctx, {
        type: 'doughnut',
        data: {
          labels: labels,
          datasets: [{ data: data, backgroundColor: colors, borderWidth: 2, borderColor: '#FFFFFF' }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          cutout: '72%',
          plugins: { legend: { display: false } }
        }
      });

      const legendContainer = document.getElementById('donutLegendList');
      legendContainer.innerHTML = labels.map((l, idx) => `
        <span class="inline-flex items-center gap-1 px-1.5 py-0.5 rounded-full bg-slate-100 text-slate-700 text-[8px] font-semibold">
          <span class="w-1.5 h-1.5 rounded-full" style="background-color: ${colors[idx % colors.length]}"></span>
          <span>${l}</span>
        </span>
      `).join('');
    }

    function switchDonutChart(type) {
      donutMode = type;
      const btnExp = document.getElementById('btnChartExp');
      const btnInc = document.getElementById('btnChartInc');

      if (type === 'expense') {
        btnExp.className = "px-2 py-0.5 rounded bg-white text-slate-900 shadow-xs";
        btnInc.className = "px-2 py-0.5 rounded text-slate-500";
      } else {
        btnInc.className = "px-2 py-0.5 rounded bg-white text-slate-900 shadow-xs";
        btnExp.className = "px-2 py-0.5 rounded text-slate-500";
      }
      initDonutChart();
    }

    function resetIncomeFilter() {
      document.getElementById('searchIncomeText').value = '';
      document.getElementById('inputIncomeFilterStart').value = '';
      document.getElementById('inputIncomeFilterEnd').value = '';
      document.getElementById('filterIncomeType').value = 'all';
      document.getElementById('filterIncomeAuthor').value = 'all';
      renderIncomeTable();
    }

    function renderIncomeTable() {
      const tbody = document.getElementById('incomeTableBody');
      const search = (document.getElementById('searchIncomeText')?.value || '').toLowerCase();
      const startDate = document.getElementById('inputIncomeFilterStart')?.value || '';
      const endDate = document.getElementById('inputIncomeFilterEnd')?.value || '';
      const typeFilter = document.getElementById('filterIncomeType')?.value || 'all';
      const authorFilter = document.getElementById('filterIncomeAuthor')?.value || 'all';

      let filtered = incomes.filter(i => {
        const itemDate = i.transaction_date;
        const matchSearch = (i.notes || '').toLowerCase().includes(search) || (i.category_name || '').toLowerCase().includes(search);
        const matchStart = !startDate || itemDate >= startDate;
        const matchEnd = !endDate || itemDate <= endDate;
        const matchType = typeFilter === 'all' || i.income_type === typeFilter;
        const matchAuthor = authorFilter === 'all' || i.author_role === authorFilter;
        return matchSearch && matchStart && matchEnd && matchType && matchAuthor;
      });

      const filteredIncomeSum = filtered.reduce((acc, item) => acc + Number(item.amount), 0);
      
      const headerTotalEl = document.getElementById('headerTotalIncome');
      if (headerTotalEl) headerTotalEl.innerText = formatIDR(filteredIncomeSum);

      const footerTotalEl = document.getElementById('tableFooterIncomeTotal');
      if (footerTotalEl) footerTotalEl.innerText = formatIDR(filteredIncomeSum);

      document.getElementById('incomeCountBadge').innerText = `${filtered.length} Data • ${formatIDR(filteredIncomeSum)}`;

      if (filtered.length === 0) {
        tbody.innerHTML = '<tr><td colspan="6" class="py-5 text-center text-slate-400 text-xs">Tidak ada data pemasukan yang cocok.</td></tr>';
        return;
      }

      // NOTE: Table row does NOT load photo to save Supabase egress! Only displays an icon.
      tbody.innerHTML = filtered.map(item => `
        <tr class="hover:bg-slate-50/80 transition">
          <td class="py-2 px-3 font-mono-num text-slate-600 text-[10px]">${item.transaction_date}</td>
          <td class="py-2 px-3">
            <span class="inline-flex items-center px-1.5 py-0.2 rounded font-bold text-[9px] ${
              item.income_type === 'gaji' ? 'bg-emerald-100 text-emerald-800' : (item.income_type === 'tarik_tabungan' ? 'bg-amber-100 text-amber-800' : 'bg-teal-100 text-teal-800')
            }">
              ${item.income_type === 'gaji' ? 'Gaji' : (item.income_type === 'tarik_tabungan' ? 'Tabungan' : 'Non-Gaji')}
            </span>
            <span class="ml-1 font-bold text-slate-800 text-[11px]">${item.category_name}</span>
          </td>
          <td class="py-2 px-3 text-slate-600 text-[11px]">${item.notes || '-'}</td>
          <td class="py-2 px-3">
            <span class="px-1.5 py-0.2 rounded-full text-[9px] font-bold ${item.author_role === 'Suami' ? 'bg-blue-50 text-blue-700' : 'bg-rose-50 text-rose-700'}">
              ${item.author_name}
            </span>
          </td>
          <td class="py-2 px-3 text-right font-bold font-mono-num text-emerald-600 text-xs">
            + ${formatIDR(item.amount)}
          </td>
          <td class="py-2 px-3 text-center">
            <button onclick="openBukuDetailModal('${item.id}', 'income')" title="Lihat Detail & Nota" class="text-slate-400 hover:text-slate-700 p-1">
              <i class="fa-solid fa-receipt ${item.photo_url ? 'text-emerald-600' : ''}"></i>
            </button>
          </td>
        </tr>
      `).join('');
    }

    function resetExpenseFilter() {
      document.getElementById('searchExpenseText').value = '';
      document.getElementById('inputExpenseFilterStart').value = '';
      document.getElementById('inputExpenseFilterEnd').value = '';
      document.getElementById('filterExpenseCategory').value = 'all';
      document.getElementById('filterExpenseAuthor').value = 'all';
      renderExpenseTable();
    }

    function renderExpenseTable() {
      const tbody = document.getElementById('expenseTableBody');
      const search = (document.getElementById('searchExpenseText')?.value || '').toLowerCase();
      const startDate = document.getElementById('inputExpenseFilterStart')?.value || '';
      const endDate = document.getElementById('inputExpenseFilterEnd')?.value || '';
      const catFilter = document.getElementById('filterExpenseCategory')?.value || 'all';
      const authorFilter = document.getElementById('filterExpenseAuthor')?.value || 'all';

      let filtered = expenses.filter(e => {
        const itemDate = e.transaction_date;
        const matchSearch = (e.notes || '').toLowerCase().includes(search) || (e.category_name || '').toLowerCase().includes(search);
        const matchStart = !startDate || itemDate >= startDate;
        const matchEnd = !endDate || itemDate <= endDate;
        const matchCat = catFilter === 'all' || e.category_id === catFilter;
        const matchAuthor = authorFilter === 'all' || e.author_role === authorFilter;
        return matchSearch && matchStart && matchEnd && matchCat && matchAuthor;
      });

      const filteredExpenseSum = filtered.reduce((acc, item) => acc + Number(item.amount), 0);

      const headerTotalEl = document.getElementById('headerTotalExpense');
      if (headerTotalEl) headerTotalEl.innerText = formatIDR(filteredExpenseSum);

      const footerTotalEl = document.getElementById('tableFooterExpenseTotal');
      if (footerTotalEl) footerTotalEl.innerText = formatIDR(filteredExpenseSum);

      document.getElementById('expenseCountBadge').innerText = `${filtered.length} Data • ${formatIDR(filteredExpenseSum)}`;

      if (filtered.length === 0) {
        tbody.innerHTML = '<tr><td colspan="6" class="py-5 text-center text-slate-400 text-xs">Tidak ada data pengeluaran yang cocok.</td></tr>';
        return;
      }

      // NOTE: Table row does NOT load photo to save Supabase egress! Only displays an icon.
      tbody.innerHTML = filtered.map(item => `
        <tr class="hover:bg-slate-50/80 transition">
          <td class="py-2 px-3 font-mono-num text-slate-600 text-[10px]">${item.transaction_date}</td>
          <td class="py-2 px-3 font-bold text-slate-800 text-[11px]">${item.category_name}</td>
          <td class="py-2 px-3 text-slate-600 text-[11px]">${item.notes || '-'}</td>
          <td class="py-2 px-3">
            <span class="px-1.5 py-0.2 rounded-full text-[9px] font-bold ${item.author_role === 'Suami' ? 'bg-blue-50 text-blue-700' : 'bg-rose-50 text-rose-700'}">
              ${item.author_name}
            </span>
          </td>
          <td class="py-2 px-3 text-right font-bold font-mono-num text-orange-600 text-xs">
            - ${formatIDR(item.amount)}
          </td>
          <td class="py-2 px-3 text-center">
            <button onclick="openBukuDetailModal('${item.id}', 'expense')" title="Lihat Detail & Nota" class="text-slate-400 hover:text-slate-700 p-1">
              <i class="fa-solid fa-receipt ${item.photo_url ? 'text-[#F97316]' : ''}"></i>
            </button>
          </td>
        </tr>
      `).join('');
    }

    function populateCategorySelectors() {
      const incSelect = document.getElementById('incomeCategorySelect');
      const incCats = categoriesMaster.filter(c => c.type === 'income' && c.is_active);
      incSelect.innerHTML = incCats.map(c => `<option value="${c.id}">${c.name}</option>`).join('');

      const expSelect = document.getElementById('expenseCategorySelect');
      const filterExpSelect = document.getElementById('filterExpenseCategory');
      const expCats = categoriesMaster.filter(c => c.type === 'expense' && c.is_active);

      expSelect.innerHTML = expCats.map(c => `<option value="${c.id}">${c.name}</option>`).join('');
      filterExpSelect.innerHTML = '<option value="all">Semua Kategori</option>' + expCats.map(c => `<option value="${c.id}">${c.name}</option>`).join('');

      const masterContainer = document.getElementById('masterCategoryList');
      masterContainer.innerHTML = categoriesMaster.map(c => `
        <div class="p-2 rounded-xl border border-slate-200 bg-slate-50 flex items-center justify-between text-xs">
          <div class="flex items-center gap-2">
            <span class="w-2 h-2 rounded-full ${c.type === 'income' ? 'bg-emerald-500' : 'bg-orange-500'}"></span>
            <span class="font-bold text-slate-800 text-[11px]">${c.name}</span>
          </div>
          <button onclick="toggleCategoryActive('${c.id}')" class="px-2 py-0.5 rounded text-[9px] font-bold ${c.is_active ? 'bg-emerald-100 text-emerald-700' : 'bg-slate-200 text-slate-500'}">
            ${c.is_active ? 'Aktif' : 'Non-aktif'}
          </button>
        </div>
      `).join('');
    }

    function renderSavingsHistory() {
      const container = document.getElementById('savingsHistoryTable');
      if (savingsHistory.length === 0) {
        container.innerHTML = '<div class="py-3 text-center text-xs text-slate-400">Belum ada riwayat penutupan tabungan.</div>';
        return;
      }

      container.innerHTML = savingsHistory.map(s => `
        <div class="py-2.5 flex items-center justify-between text-xs border-b border-slate-100">
          <div class="flex items-center gap-2.5">
            <div class="w-8 h-8 rounded-xl ${s.is_deduction ? 'bg-rose-100 text-rose-700' : 'bg-amber-100 text-amber-700'} flex items-center justify-center font-bold text-xs">
              <i class="fa-solid ${s.is_deduction ? 'fa-arrow-up-from-bracket' : 'fa-vault'}"></i>
            </div>
            <div>
              <span class="font-bold text-slate-900 text-xs">${s.period_month}</span>
              <p class="text-[10px] text-slate-400">${s.notes || 'Surplus tabungan'}</p>
            </div>
          </div>
          <span class="font-bold font-mono-num ${s.is_deduction ? 'text-rose-600' : 'text-amber-600'} text-xs">
            ${s.is_deduction ? '-' : '+'} ${formatIDR(s.amount_saved)}
          </span>
        </div>
      `).join('');
    }

    function openModal(id) {
      document.getElementById(id).classList.remove('hidden');
      const today = new Date().toLocaleDateString('en-CA');
      if (id === 'modalAddIncome') {
        document.getElementById('inputIncomeDate').value = today;
      } else if (id === 'modalAddExpense') {
        document.getElementById('inputExpenseDate').value = today;
      }
    }

    function closeModal(id) {
      document.getElementById(id).classList.add('hidden');
      // CRITICAL EGRESS SAVING: Instantly remove photo src to prevent idle memory/network consumption
      if (id === 'modalBukuDetail') {
        const photoImg = document.getElementById('detailTransPhoto');
        if (photoImg) photoImg.src = '';
      }
    }

    function switchView(viewName) {
      const views = ['Dashboard', 'Pemasukan', 'Pengeluaran', 'Riwayat', 'Master'];
      views.forEach(v => {
        const el = document.getElementById(`view${v}`);
        if (el) el.classList.add('hidden');
        
        const navL = document.getElementById(`navLink${v}`);
        if (navL) navL.className = "sidebar-nav-link flex items-center gap-2.5 px-3 py-2 rounded-xl text-xs font-bold transition text-slate-600 hover:bg-slate-50";
      });

      const activeView = document.getElementById(`view${capitalize(viewName)}`);
      if (activeView) activeView.classList.remove('hidden');

      const activeNavLink = document.getElementById(`navLink${capitalize(viewName)}`);
      if (activeNavLink) activeNavLink.className = "sidebar-nav-link flex items-center gap-2.5 px-3 py-2 rounded-xl text-xs font-bold transition text-white bg-theme-primary shadow-xs";

      if (viewName === 'dashboard') {
        setTimeout(() => {
          if (lineChartInstance) lineChartInstance.resize();
          if (donutChartInstance) donutChartInstance.resize();
        }, 100);
      } else if (viewName === 'pemasukan') {
        renderIncomeTable();
      } else if (viewName === 'pengeluaran') {
        renderExpenseTable();
      } else if (viewName === 'riwayat') {
        renderSavingsHistory();
      }
    }

    function capitalize(str) {
      return str.charAt(0).toUpperCase() + str.slice(1);
    }

    function handleMobileNavSwitch(viewName, tabIndex) {
      switchView(viewName);
      currentMobileTabIndex = tabIndex;

      const navBar = document.querySelector('.curved-bottom-bar');
      const buttons = document.querySelectorAll('.mobile-nav-item');
      const activeBtn = buttons[tabIndex];

      const notch = document.getElementById('navSvgCurve');
      const bubble = document.getElementById('navActiveIndicator');
      const icon = document.getElementById('navActiveIcon');

      if (activeBtn && navBar && bubble && notch) {
        const barRect = navBar.getBoundingClientRect();
        const btnRect = activeBtn.getBoundingClientRect();
        const targetCenterX = (btnRect.left - barRect.left) + (btnRect.width / 2);

        notch.style.transform = `translateX(${targetCenterX - 55}px)`;
        bubble.style.transform = `translateX(${targetCenterX - 26}px)`;
      }

      const icons = [
        'fa-chart-pie',
        'fa-circle-plus',
        'fa-circle-minus',
        'fa-vault',
        'fa-sliders'
      ];
      
      if (icon) {
        icon.className = `fa-solid ${icons[tabIndex]}`;
        icon.classList.remove('nav-bubble-animate');
        void icon.offsetWidth;
        icon.classList.add('nav-bubble-animate');
      }

      document.querySelectorAll('.mobile-nav-item').forEach((btn, idx) => {
        const itemIcon = btn.querySelector('.mobile-nav-icon');
        const itemLabel = btn.querySelector('.mobile-nav-label');
        const itemDot = btn.querySelector('.mobile-nav-dot');

        if (idx === tabIndex) {
          if (itemIcon) {
            itemIcon.className = "mobile-nav-icon fa-solid " + icons[idx] + " text-base transition-all duration-300 opacity-0 -translate-y-2 scale-75 pointer-events-none";
          }
          if (itemLabel) {
            itemLabel.className = "mobile-nav-label text-[10px] mt-3.5 font-extrabold tracking-tight text-theme-primary transition-all duration-300";
          }
          if (itemDot) {
            itemDot.className = "mobile-nav-dot w-1.5 h-1.5 rounded-full bg-theme-primary mt-0.5 opacity-100 scale-100 transition-all duration-300";
          }
        } else {
          if (itemIcon) {
            itemIcon.className = "mobile-nav-icon fa-solid " + icons[idx] + " text-sm text-slate-400 group-hover:text-slate-600 transition-all duration-300 opacity-100 translate-y-0 scale-100";
          }
          if (itemLabel) {
            itemLabel.className = "mobile-nav-label text-[9px] mt-1 font-semibold text-slate-400 group-hover:text-slate-600 transition-all duration-300";
          }
          if (itemDot) {
            itemDot.className = "mobile-nav-dot w-1.5 h-1.5 rounded-full bg-theme-primary mt-0.5 opacity-0 scale-0 transition-all duration-300";
          }
        }
      });
    }

    function updateUserUI() {
      const user = profiles[activeRole] || profiles['Suami'];

      document.getElementById('topBarUserName').innerText = user.role;
      document.getElementById('topBarUserAvatar').src = user.avatar_url;

      const sideName = document.getElementById('sidebarUserName');
      if (sideName) sideName.innerText = user.full_name;
      const sideRole = document.getElementById('sidebarUserRoleBadge');
      if (sideRole) sideRole.innerText = user.role;
      const sideAvatar = document.getElementById('sidebarUserAvatar');
      if (sideAvatar) sideAvatar.src = user.avatar_url;
      const sideId = document.getElementById('sidebarUserIdLabel');
      if (sideId) sideId.innerText = `ID: ${user.username}`;

      document.getElementById('profileNameSuami').innerText = profiles['Suami'].full_name;
      document.getElementById('profileUserSuami').innerText = `ID: ${profiles['Suami'].username}`;
      document.getElementById('profileAvatarSuami').src = profiles['Suami'].avatar_url;

      document.getElementById('profileNameIstri').innerText = profiles['Istri'].full_name;
      document.getElementById('profileUserIstri').innerText = `ID: ${profiles['Istri'].username}`;
      document.getElementById('profileAvatarIstri').src = profiles['Istri'].avatar_url;

      const masterSec = document.getElementById('masterDataRestrictedSection');
      if (masterSec) {
        if (activeRole === 'Suami') {
          masterSec.classList.remove('opacity-60', 'pointer-events-none');
          document.getElementById('badgeSuamiAccess').innerText = 'Akses Suami Aktif';
        } else {
          masterSec.classList.add('opacity-60', 'pointer-events-none');
          document.getElementById('badgeSuamiAccess').innerText = 'Terkunci (Hanya Suami)';
        }
      }
    }

    function editProfile(role) {
      document.getElementById('editProfileRole').value = role;
      document.getElementById('modalEditProfileTitle').innerText = `Ubah Akun & Sandi ${role}`;
      document.getElementById('inputEditProfileName').value = profiles[role].full_name;
      document.getElementById('inputEditProfileUsername').value = profiles[role].username;
      document.getElementById('inputEditProfilePassword').value = profiles[role].password;
      document.getElementById('inputEditProfileAvatar').value = profiles[role].avatar_url;
      openModal('modalEditProfile');
    }

    async function handleSaveProfile(e) {
      e.preventDefault();
      const role = document.getElementById('editProfileRole').value;
      profiles[role].full_name = document.getElementById('inputEditProfileName').value.trim();
      profiles[role].username = document.getElementById('inputEditProfileUsername').value.trim().toLowerCase();
      profiles[role].password = document.getElementById('inputEditProfilePassword').value.trim();
      profiles[role].avatar_url = document.getElementById('inputEditProfileAvatar').value.trim();
      
      if (currentAuthUser && currentAuthUser.role === role) {
        currentAuthUser = profiles[role];
        // Perbarui sesi tersimpan di HP
        localStorage.setItem('family_finance_user_session', JSON.stringify(currentAuthUser));
        localStorage.setItem('family_finance_auth', JSON.stringify({ username: currentAuthUser.username }));
      }

      if (supabaseClient) {
        try {
          await supabaseClient.from('profiles').update({
            full_name: profiles[role].full_name,
            username: profiles[role].username,
            password_hash: profiles[role].password,
            avatar_url: profiles[role].avatar_url,
            updated_at: new Date().toISOString()
          }).eq('role', role);
        } catch (err) {
          console.warn("Supabase profile update:", err);
        }
      }

      updateUserUI();
      closeModal('modalEditProfile');
      showToast(`Profil ${role} berhasil diperbarui!`, 'success');
    }

    // Helper: Upload file ke Supabase Storage (Bucket: receipts)
    async function uploadReceiptFileToSupabase(file) {
      if (!file || !supabaseClient) return null;
      try {
        const fileExt = file.name.split('.').pop() || 'jpg';
        const cleanName = `${Date.now()}_${generateUUID().slice(0, 8)}.${fileExt}`;
        const filePath = `receipts/${cleanName}`;

        const { data, error } = await supabaseClient.storage
          .from('receipts')
          .upload(filePath, file, { cacheControl: '3600', upsert: false });

        if (error) {
          console.warn("Supabase storage upload error:", error);
          return null;
        }

        const { data: { publicUrl } } = supabaseClient.storage
          .from('receipts')
          .getPublicUrl(filePath);

        return publicUrl;
      } catch (err) {
        console.warn("Storage upload exception:", err);
        return null;
      }
    }

    function handleReceiptFileSelection(e, type) {
      const file = e.target.files[0];
      if (!file) return;

      selectedReceiptFiles[type] = file;
      
      // Tampilkan preview lokal menggunakan createObjectURL (TIDAK menyedot kuota Supabase)
      const localPreviewUrl = URL.createObjectURL(file);
      const preview = document.getElementById(type === 'income' ? 'previewIncomePhoto' : 'previewExpensePhoto');
      const wrapper = document.getElementById(type === 'income' ? 'previewIncomePhotoWrapper' : 'previewExpensePhotoWrapper');
      if (preview && wrapper) {
        preview.src = localPreviewUrl;
        wrapper.classList.remove('hidden');
      }
    }

    function removeSelectedReceiptFile(type) {
      selectedReceiptFiles[type] = null;
      const inputEl = document.getElementById(type === 'income' ? 'inputIncomeReceiptFile' : 'inputExpenseReceiptFile');
      if (inputEl) inputEl.value = '';
      const wrapper = document.getElementById(type === 'income' ? 'previewIncomePhotoWrapper' : 'previewExpensePhotoWrapper');
      if (wrapper) wrapper.classList.add('hidden');
    }

    async function handleSaveIncome(e) {
      e.preventDefault();
      const submitBtn = document.getElementById('btnSubmitIncome');
      if (submitBtn) {
        submitBtn.disabled = true;
        submitBtn.innerText = 'Menyimpan ke Cloud...';
      }

      try {
        const incomeType = document.querySelector('input[name="income_type"]:checked').value;
        const catId = document.getElementById('incomeCategorySelect').value;
        const categoryObj = categoriesMaster.find(c => c.id === catId);
        const amount = parseFloat(document.getElementById('inputIncomeAmount').value);
        const transDate = document.getElementById('inputIncomeDate').value;
        const notes = document.getElementById('inputIncomeNotes').value;

        const user = profiles[activeRole] || profiles['Suami'];

        // 1. Unggah bukti ke Supabase Storage jika ada
        let uploadedPhotoUrl = null;
        if (selectedReceiptFiles.income) {
          submitBtn.innerText = 'Mengunggah Bukti Nota...';
          uploadedPhotoUrl = await uploadReceiptFileToSupabase(selectedReceiptFiles.income);
        }

        const newRecord = {
          id: generateUUID(),
          user_id: user ? user.id : null,
          author_name: user ? user.full_name : 'Keluarga',
          author_role: user ? user.role : 'Suami',
          category_id: catId || null,
          category_name: categoryObj ? categoryObj.name : (incomeType === 'gaji' ? 'Gaji Pokok' : 'Pemasukan'),
          income_type: incomeType,
          amount: amount,
          transaction_date: transDate,
          notes: notes || null,
          photo_url: uploadedPhotoUrl || null
        };

        // 2. Simpan ke database Supabase dan verifikasi konfirmasi balasan
        if (supabaseClient) {
          submitBtn.innerText = 'Menyinkronkan ke Supabase...';
          const { data, error } = await supabaseClient.from('incomes').insert([newRecord]);
          if (error) {
            console.error("Gagal simpan pemasukan ke Supabase:", error);
            showToast(`Gagal simpan ke Supabase: ${error.message}`, 'error');
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.innerText = 'Simpan';
            }
            return; // Hentikan agar data palsu tidak tersimpan di memori lokal
          }
        }

        // 3. Hanya perbarui memori lokal jika database Supabase sukses mencatatnya
        incomes.unshift({ ...newRecord, created_at: new Date().toISOString() });
        closeModal('modalAddIncome');
        e.target.reset();
        removeSelectedReceiptFile('income');

        updateDashboardMetrics();
        renderIncomeTable();
        showToast(`Pemasukan ${formatIDR(amount)} berhasil disimpan ke database!`, 'success');
      } catch (err) {
        console.error("Kesalahan simpan pemasukan:", err);
        showToast(`Terjadi kesalahan: ${err.message}`, 'error');
      } finally {
        if (submitBtn) {
          submitBtn.disabled = false;
          submitBtn.innerText = 'Simpan';
        }
      }
    }

    async function handleSaveExpense(e) {
      e.preventDefault();
      const submitBtn = document.getElementById('btnSubmitExpense');
      if (submitBtn) {
        submitBtn.disabled = true;
        submitBtn.innerText = 'Menyimpan ke Cloud...';
      }

      try {
        const catId = document.getElementById('expenseCategorySelect').value;
        const categoryObj = categoriesMaster.find(c => c.id === catId);
        const amount = parseFloat(document.getElementById('inputExpenseAmount').value);
        const transDate = document.getElementById('inputExpenseDate').value;
        const notes = document.getElementById('inputExpenseNotes').value;

        const user = profiles[activeRole] || profiles['Suami'];

        // 1. Unggah bukti ke Supabase Storage jika ada
        let uploadedPhotoUrl = null;
        if (selectedReceiptFiles.expense) {
          submitBtn.innerText = 'Mengunggah Bukti Struk...';
          uploadedPhotoUrl = await uploadReceiptFileToSupabase(selectedReceiptFiles.expense);
        }

        const newRecord = {
          id: generateUUID(),
          user_id: user ? user.id : null,
          author_name: user ? user.full_name : 'Keluarga',
          author_role: user ? user.role : 'Suami',
          category_id: catId || null,
          category_name: categoryObj ? categoryObj.name : 'Pengeluaran',
          amount: amount,
          transaction_date: transDate,
          notes: notes || null,
          photo_url: uploadedPhotoUrl || null
        };

        // 2. Simpan ke database Supabase dan verifikasi konfirmasi balasan
        if (supabaseClient) {
          submitBtn.innerText = 'Menyinkronkan ke Supabase...';
          const { data, error } = await supabaseClient.from('expenses').insert([newRecord]);
          if (error) {
            console.error("Gagal simpan pengeluaran ke Supabase:", error);
            showToast(`Gagal simpan ke Supabase: ${error.message}`, 'error');
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.innerText = 'Simpan';
            }
            return; // Hentikan agar data palsu tidak tersimpan di memori lokal
          }
        }

        // 3. Hanya perbarui memori lokal jika database Supabase sukses mencatatnya
        expenses.unshift({ ...newRecord, created_at: new Date().toISOString() });
        closeModal('modalAddExpense');
        e.target.reset();
        removeSelectedReceiptFile('expense');

        updateDashboardMetrics();
        renderExpenseTable();
        showToast(`Pengeluaran ${formatIDR(amount)} berhasil dicatat di database!`, 'success');
      } catch (err) {
        console.error("Kesalahan simpan pengeluaran:", err);
        showToast(`Terjadi kesalahan: ${err.message}`, 'error');
      } finally {
        if (submitBtn) {
          submitBtn.disabled = false;
          submitBtn.innerText = 'Simpan';
        }
      }
    }

    function openBukuDetailModal(id, type) {
      const list = type === 'income' ? incomes : expenses;
      const item = list.find(x => x.id === id);
      if (!item) return;

      activeDetailTransaction = { id, type, item };

      document.getElementById('detailTransDate').innerText = item.transaction_date;
      document.getElementById('detailTransCat').innerText = item.category_name;
      document.getElementById('detailTransAuthor').innerText = `${item.author_name} (${item.author_role})`;
      document.getElementById('detailTransAmount').innerText = (type === 'income' ? '+ ' : '- ') + formatIDR(item.amount);
      document.getElementById('detailTransNotes').innerText = item.notes || 'Tidak ada catatan khusus.';

      const photoSec = document.getElementById('detailTransPhotoSection');
      const photoImg = document.getElementById('detailTransPhoto');
      const photoLoading = document.getElementById('detailTransPhotoLoading');

      // CRITICAL EGRESS SAVING LOGIC:
      // Foto nota dari Supabase HANYA di-download ketika modal rincian dibuka oleh pengguna!
      if (item.photo_url) {
        photoSec.classList.remove('hidden');
        photoLoading.classList.remove('hidden');
        photoImg.classList.add('hidden');

        photoImg.onload = () => {
          photoLoading.classList.add('hidden');
          photoImg.classList.remove('hidden');
        };
        photoImg.onerror = () => {
          photoLoading.classList.add('hidden');
          photoSec.classList.add('hidden');
        };

        // Pemicu unduhan gambar dari Supabase Storage
        photoImg.src = item.photo_url;
      } else {
        photoSec.classList.add('hidden');
        photoImg.src = '';
      }

      openModal('modalBukuDetail');
    }

    function executeDeleteFromBukuDetail() {
      if (!activeDetailTransaction) return;
      const { id, type, item } = activeDetailTransaction;

      closeModal('modalBukuDetail');

      showConfirmModal('Hapus Transaksi', 'Apakah Anda yakin ingin menghapus catatan transaksi ini secara permanen?', async () => {
        if (type === 'income') {
          const idx = incomes.findIndex(i => i.id === id);
          if (idx !== -1) incomes.splice(idx, 1);
          renderIncomeTable();
        } else {
          const idx = expenses.findIndex(e => e.id === id);
          if (idx !== -1) expenses.splice(idx, 1);
          renderExpenseTable();
        }

        updateDashboardMetrics();
        showToast('Catatan transaksi berhasil dihapus.', 'warning');

        if (supabaseClient) {
          try {
            const table = type === 'income' ? 'incomes' : 'expenses';
            await supabaseClient.from(table).delete().eq('id', id);

            // Opsional: Hapus file nota dari Supabase Storage jika ada
            if (item && item.photo_url && item.photo_url.includes('receipts/')) {
              const fileName = item.photo_url.split('/receipts/').pop();
              if (fileName) {
                await supabaseClient.storage.from('receipts').remove([`receipts/${fileName}`]);
              }
            }
          } catch (err) {
            console.warn("Supabase delete error:", err);
          }
        }
      });
    }

    function openTarikTabunganModal() {
      openModal('modalTarikTabungan');
    }

    async function handleTarikTabunganSubmit(e) {
      e.preventDefault();
      const amount = parseFloat(document.getElementById('inputTarikAmount').value);
      const notes = document.getElementById('inputTarikNotes').value.trim();

      const totalTabungan = savingsHistory.reduce((s, x) => s + (x.is_deduction ? -Number(x.amount_saved) : Number(x.amount_saved)), 0);
      if (amount > totalTabungan) {
        showToast('Nominal penarikan melebihi saldo tabungan saat ini!', 'warning');
        return;
      }

      const user = profiles[activeRole] || profiles['Suami'];

      const savDeduction = {
        id: generateUUID(),
        period_month: 'Tarik Tabungan',
        amount_saved: amount,
        notes: notes || 'Penarikan dana cadangan',
        is_deduction: true,
        created_at: new Date().toISOString()
      };
      savingsHistory.unshift(savDeduction);

      const incRecord = {
        id: generateUUID(),
        user_id: user.id,
        author_name: user.full_name,
        author_role: user.role,
        category_id: null,
        category_name: 'Tarik Tabungan',
        income_type: 'tarik_tabungan',
        amount: amount,
        transaction_date: new Date().toLocaleDateString('en-CA'),
        notes: `[Dari Tabungan] ${notes}`,
        created_at: new Date().toISOString()
      };
      incomes.unshift(incRecord);

      closeModal('modalTarikTabungan');
      e.target.reset();
      updateDashboardMetrics();
      renderIncomeTable();
      renderSavingsHistory();
      showToast(`Dana ${formatIDR(amount)} berhasil dipindahkan ke saldo kas!`, 'success');

      if (supabaseClient) {
        try {
          await supabaseClient.from('savings_history').insert(savDeduction);
          await supabaseClient.from('incomes').insert(incRecord);
        } catch (err) {
          console.warn("Supabase tarik tabungan sync:", err);
        }
      }
    }

    function handleSaveCategory(e) {
      e.preventDefault();
      const name = document.getElementById('inputCategoryName').value.trim();
      const type = document.getElementById('inputCategoryType').value;

      const newCat = {
        id: generateUUID(),
        name: name,
        type: type,
        is_active: true
      };

      categoriesMaster.push(newCat);
      populateCategorySelectors();
      closeModal('modalAddCategory');
      e.target.reset();
      showToast(`Kategori ${name} berhasil ditambahkan.`, 'success');

      if (supabaseClient) {
        supabaseClient.from('categories_master').insert({ id: newCat.id, name: newCat.name, is_active: true }).catch(() => {});
      }
    }

    function toggleCategoryActive(catId) {
      const cat = categoriesMaster.find(c => c.id === catId);
      if (cat) {
        cat.is_active = !cat.is_active;
        populateCategorySelectors();
        showToast(`Status kategori ${cat.name} diperbarui.`, 'info');
      }
    }

    function saveLoginBgSetting() {
      const url = document.getElementById('inputMasterLoginBgUrl').value.trim();
      localStorage.setItem('family_finance_login_bg', url);
      applyLoginBg(url);
      showToast('Foto latar belakang login berhasil disimpan!', 'success');
    }

    function resetLoginBgSetting() {
      document.getElementById('inputMasterLoginBgUrl').value = '';
      localStorage.removeItem('family_finance_login_bg');
      applyLoginBg('');
      showToast('Latar belakang login dikembalikan ke standar.', 'info');
    }

    function applyLoginBg(url) {
      const gate = document.getElementById('modalLoginGate');
      if (!gate) return;
      if (url) {
        gate.style.backgroundImage = `linear-gradient(rgba(15, 23, 42, 0.75), rgba(15, 23, 42, 0.85)), url('${url}')`;
        gate.style.backgroundSize = 'cover';
        gate.style.backgroundPosition = 'center';
      } else {
        gate.style.backgroundImage = '';
        gate.style.backgroundColor = 'rgba(15, 23, 42, 0.8)';
      }
    }

    function isRealtimeWebSocketAllowed() {
      try {
        if (window.self !== window.top) return false;
        return typeof WebSocket !== 'undefined';
      } catch (e) {
        return false;
      }
    }

    async function initSupabase() {
      try {
        if (!window.supabase) return;
        supabaseClient = window.supabase.createClient(SUPABASE_CONFIG.URL, SUPABASE_CONFIG.ANON_KEY);
        
        // Ambil Data Profil Awal
        const { data: profData } = await supabaseClient.from('profiles').select('*');
        if (profData && profData.length > 0) {
          profData.forEach(p => {
            if (p.role === 'Suami' || p.role === 'Istri') {
              profiles[p.role] = {
                id: p.id,
                full_name: p.full_name,
                role: p.role,
                username: p.username,
                password: p.password_hash || p.password || '123',
                avatar_url: p.avatar_url
              };
            }
          });
        }

        // Ambil Master Kategori Nyata dari Supabase
        const { data: catData } = await supabaseClient.from('categories_master').select('*').order('name');
        if (catData && catData.length > 0) {
          categoriesMaster = catData;
          populateCategorySelectors();
        }

        // Ambil Data Pemasukan Awal
        const { data: incData, error: incErr } = await supabaseClient.from('incomes').select('*').order('created_at', { ascending: false });
        if (!incErr && incData) incomes = incData;

        // Ambil Data Pengeluaran Awal
        const { data: expData, error: expErr } = await supabaseClient.from('expenses').select('*').order('created_at', { ascending: false });
        if (!expErr && expData) expenses = expData;

        // Ambil Data Tabungan Awal
        const { data: savData, error: savErr } = await supabaseClient.from('savings_history').select('*').order('created_at', { ascending: false });
        if (!savErr && savData) savingsHistory = savData;

        // Periksa apakah hari ini tgl 10 gajian untuk tutup buku otomatis
        await checkAndExecuteAutoTutupBuku();

        if (!isRealtimeWebSocketAllowed()) {
          const rtBadge = document.getElementById('topBarRealtimeBadge');
          if (rtBadge) rtBadge.innerHTML = '<span class="w-1.5 h-1.5 rounded-full bg-emerald-500 mr-1"></span> Cloud Siap';
          const sbLabel = document.getElementById('sidebarSyncLabel');
          if (sbLabel) sbLabel.innerText = 'Siap (Event Realtime)';
          return;
        }

        // Pure Event-Driven Supabase Realtime
        try {
          realtimeChannel = supabaseClient.channel('realtime_family_finance')
            .on('postgres_changes', { event: '*', schema: 'public', table: 'incomes' }, (payload) => {
              if (payload.eventType === 'INSERT') {
                if (!incomes.some(x => x.id === payload.new.id)) incomes.unshift(payload.new);
              } else if (payload.eventType === 'DELETE') {
                incomes = incomes.filter(e => e.id !== payload.old.id);
              } else if (payload.eventType === 'UPDATE') {
                const idx = incomes.findIndex(e => e.id === payload.new.id);
                if (idx !== -1) incomes[idx] = payload.new;
              }
              updateDashboardMetrics();
              renderIncomeTable();
            })
            .on('postgres_changes', { event: '*', schema: 'public', table: 'expenses' }, (payload) => {
              if (payload.eventType === 'INSERT') {
                if (!expenses.some(x => x.id === payload.new.id)) expenses.unshift(payload.new);
              } else if (payload.eventType === 'DELETE') {
                expenses = expenses.filter(e => e.id !== payload.old.id);
              } else if (payload.eventType === 'UPDATE') {
                const idx = expenses.findIndex(e => e.id === payload.new.id);
                if (idx !== -1) expenses[idx] = payload.new;
              }
              updateDashboardMetrics();
              renderExpenseTable();
            })
            .on('postgres_changes', { event: '*', schema: 'public', table: 'savings_history' }, (payload) => {
              if (payload.eventType === 'INSERT') {
                if (!savingsHistory.some(x => x.id === payload.new.id)) savingsHistory.unshift(payload.new);
              } else if (payload.eventType === 'DELETE') {
                savingsHistory = savingsHistory.filter(e => e.id !== payload.old.id);
              } else if (payload.eventType === 'UPDATE') {
                const idx = savingsHistory.findIndex(e => e.id === payload.new.id);
                if (idx !== -1) savingsHistory[idx] = payload.new;
              }
              updateDashboardMetrics();
              renderSavingsHistory();
            })
            .on('postgres_changes', { event: '*', schema: 'public', table: 'profiles' }, (payload) => {
              if (payload.new && (payload.new.role === 'Suami' || payload.new.role === 'Istri')) {
                profiles[payload.new.role] = {
                  id: payload.new.id,
                  full_name: payload.new.full_name,
                  role: payload.new.role,
                  username: payload.new.username,
                  password: payload.new.password_hash || payload.new.password || '123',
                  avatar_url: payload.new.avatar_url
                };
                updateUserUI();
              }
            });

          realtimeChannel.subscribe((status, err) => {
            if (err) {
              console.warn("Realtime subscription notice:", err);
              return;
            }
            if (status === 'SUBSCRIBED') {
              const rtBadge = document.getElementById('topBarRealtimeBadge');
              if (rtBadge) {
                rtBadge.innerHTML = '<span class="w-1.5 h-1.5 rounded-full bg-emerald-500 mr-1 animate-ping"></span> Realtime';
              }
              const sbLabel = document.getElementById('sidebarSyncLabel');
              if (sbLabel) sbLabel.innerText = 'Tersambung (Realtime)';
            }
          });
        } catch (wsErr) {
          console.warn("Gagal inisialisasi Realtime Channel:", wsErr);
        }

      } catch (err) {
        console.warn("Supabase initialization error:", err);
      }
    }

    window.onload = async function() {
      // Inisialisasi tema lokal per perangkat (tidak menyentuh Supabase)
      initLocalTheme();

      checkAuthStatus();

      await initSupabase();

      populateCategorySelectors();
      updateDashboardMetrics();
      renderIncomeTable();
      renderExpenseTable();
      renderSavingsHistory();

      const savedLoginBg = localStorage.getItem('family_finance_login_bg');
      if (savedLoginBg) {
        document.getElementById('inputMasterLoginBgUrl').value = savedLoginBg;
        applyLoginBg(savedLoginBg);
      }

      window.addEventListener('resize', () => {
        if (window.innerWidth < 768) {
          handleMobileNavSwitch(['dashboard', 'pemasukan', 'pengeluaran', 'riwayat', 'master'][currentMobileTabIndex], currentMobileTabIndex);
        }
      });

      handleMobileNavSwitch('dashboard', 0);
      console.log("KEUANGAN KELUARGA with Supabase Storage successfully running.");
    };
  </script>
</body>
</html>
