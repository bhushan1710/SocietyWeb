<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="landing_page.aspx.cs" Inherits="Society2024.landing_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #1a202c;
            background: #f8fafc;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        header {
            background: rgba(248, 250, 252, 0.95);
            backdrop-filter: blur(10px);
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            border-bottom: 1px solid #e2e8f0;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
        }

        .logo {
    font-size: 2.5rem;
    font-weight: 700;
    color: #4287f5;
    margin-bottom: 10px;
    letter-spacing: -0.5px;
}
        



        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #64748b;
            font-weight: 500;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #2d3748;
        }

        .cta-button {
            background: #3b82f6;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 0.9rem;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }

        .cta-button:hover {
            background: #2563eb;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.15);
        }

        /* Hero Section */
        .hero {
            padding: 120px 0 120px;
            min-height: 100vh;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 50%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="%23e2e8f0" stroke-width="0.3"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>') repeat;
            opacity: 0.4;
        }

        .hero-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 6rem;
            align-items: center;
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 0 auto;
        }

        .hero-text h1 {
            font-size: 4rem;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 2rem;
            line-height: 1.1;
            letter-spacing: -0.02em;
        }

        .hero-text .highlight {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-text p {
            font-size: 1.25rem;
            color: #64748b;
            margin-bottom: 3rem;
            line-height: 1.7;
            font-weight: 400;
        }
        

        .hero-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn-primary {
            background: #3b82f6;
            color: white;
            padding: 16px 32px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-secondary {
            background: transparent;
            color: #64748b;
            padding: 16px 32px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
        }

        .btn-primary:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.15);
        }

        .btn-secondary:hover {
            border-color: #3b82f6;
            color: #3b82f6;
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.1);
        }

        .hero-visual {
            position: relative;
        }

        /* Enhanced Dashboard Preview */
        .dashboard-preview {
            background: white;
            border-radius: 16px;
            box-shadow: 
                0 20px 25px -5px rgba(0, 0, 0, 0.1),
                0 10px 10px -5px rgba(0, 0, 0, 0.04);
            border: 1px solid #f1f5f9;
            padding: 2rem;
            position: relative;
            overflow: hidden;
            transition: all 0.5s ease;
        }

        .dashboard-preview:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 
                0 25px 50px -12px rgba(0, 0, 0, 0.15),
                0 0 0 1px rgba(59, 130, 246, 0.05);
        }

        .dashboard-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #f1f5f9;
        }

        .dashboard-icon {
            width: 40px;
            height: 40px;
            background: #f8fafc;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        .dashboard-title {
            color: #1a202c;
            font-size: 1.125rem;
            font-weight: 600;
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .stat-card {
            background: #f8fafc;
            padding: 1.25rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            border-color: #cbd5e1;
        }

        .stat-card.due-payments {
            background: #fef2f2;
            border-color: #fecaca;
        }

        .stat-card.defaulters {
            background: #f0fdf4;
            border-color: #bbf7d0;
        }

        .stat-card.members {
            background: #fefce8;
            border-color: #fde047;
        }

        .stat-card.income {
            background: #f0f9ff;
            border-color: #bae6fd;
        }

        .stat-value {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
            color: #1a202c;
        }

        .stat-card.due-payments .stat-value {
            color: #dc2626;
        }

        .stat-card.defaulters .stat-value {
            color: #16a34a;
        }

        .stat-card.members .stat-value {
            color: #ca8a04;
        }

        .stat-card.income .stat-value {
            color: #2563eb;
        }

        .stat-label {
            color: #64748b;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .chart-area {
            background: #f8fafc;
            height: 120px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }

        .chart-placeholder {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: #64748b;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .chart-bars {
            display: flex;
            align-items: end;
            gap: 3px;
            height: 50px;
        }

        .chart-bar {
            width: 6px;
            background: linear-gradient(to top, #3b82f6, #60a5fa);
            border-radius: 3px 3px 0 0;
            opacity: 0.8;
            animation: growBar 2s ease-out infinite alternate;
        }

        .chart-bar:nth-child(1) { height: 15px; animation-delay: 0s; }
        .chart-bar:nth-child(2) { height: 28px; animation-delay: 0.2s; }
        .chart-bar:nth-child(3) { height: 40px; animation-delay: 0.4s; }
        .chart-bar:nth-child(4) { height: 22px; animation-delay: 0.6s; }
        .chart-bar:nth-child(5) { height: 35px; animation-delay: 0.8s; }
        .chart-bar:nth-child(6) { height: 18px; animation-delay: 1s; }
        .chart-bar:nth-child(7) { height: 32px; animation-delay: 1.2s; }

        @keyframes growBar {
            0% { transform: scaleY(0.3); opacity: 0.5; }
            100% { transform: scaleY(1); opacity: 0.8; }
        }

        /* Features Section */
        .features {
            padding: 80px 0;
            background: white;
        }

        .section-header {
            text-align: center;
            margin-bottom: 4rem;
        }

        .section-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 1rem;
        }

        .section-header p {
            font-size: 1.125rem;
            color: #64748b;
            max-width: 600px;
            margin: 0 auto;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border-color: #cbd5e1;
        }

        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            display: block;
        }

        .feature-card h3 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1a202c;
            margin-bottom: 0.75rem;
        }

        .feature-card p {
            color: #64748b;
            line-height: 1.6;
            font-size: 0.95rem;
        }

        /* Stats Section */
        .stats {
            padding: 100px 0;
            background: #1e293b;
            color: white;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            text-align: center;
        }

        .stat-item h3 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #3b82f6;
        }

        .stat-item p {
            color: #94a3b8;
            font-size: 1rem;
            font-weight: 500;
        }

        /* Mobile App Section */
        .mobile-app {
            padding: 80px 0;
            background: #f8fafc;
        }

        .app-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
        }

        .app-features {
            list-style: none;
            margin: 2rem 0;
        }

        .app-features li {
            padding: 0.75rem 0;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1rem;
            color: #4b5563;
        }

        .app-features li::before {
            content: "✓";
            background: #16a34a;
            color: white;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 0.75rem;
            flex-shrink: 0;
        }

        /* CTA Section */
        .cta-section {
            padding: 80px 0;
            background: #3b82f6;
            color: white;
            text-align: center;
        }

        .cta-section h2 {
            font-size: 2.25rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .cta-section p {
            font-size: 1.125rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .cta-section .btn-primary {
            background: white;
            color: #3b82f6;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .cta-section .btn-primary:hover {
            background: #f9fafb;
            color: #2563eb;
        }

        /* Footer */
        footer {
            background: #1e293b;
            color: white;
            padding: 40px 0;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .footer-section h3 {
            margin-bottom: 1rem;
            color: #e2e8f0;
            font-size: 1.125rem;
            font-weight: 600;
        }

        .footer-section p, .footer-section a {
            color: #94a3b8;
            text-decoration: none;
            font-size: 0.9rem;
            line-height: 1.5;
        }

        .footer-section a:hover {
            color: white;
        }

        /* Enhanced Responsive Design */
        
        /* Tablet styles */
        @media (max-width: 1024px) {
            .container {
                padding: 0 30px;
            }
            
            .hero-text h1 {
                font-size: 3.5rem;
            }
            
            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .hero-content {
                gap: 4rem;
            }
        }

        /* Mobile Navigation */
        @media (max-width: 768px) {
            .nav-links {
                position: fixed;
                top: 80px;
                right: -100%;
                width: 100%;
                height: calc(100vh - 80px);
                background: rgba(248, 250, 252, 0.98);
                backdrop-filter: blur(20px);
                flex-direction: column;
                justify-content: flex-start;
                align-items: center;
                padding: 2rem 0;
                transition: right 0.3s ease;
                border-left: 1px solid #e2e8f0;
                z-index: 999;
            }
            
            .nav-links.active {
                right: 0;
            }
            
            .nav-links li {
                margin: 1rem 0;
            }
            
            .nav-links a {
                font-size: 1.1rem;
                padding: 1rem 2rem;
                display: block;
                text-align: center;
            }
            
            .mobile-menu-toggle.active span:nth-child(1) {
                transform: rotate(-45deg) translate(-5px, 6px);
            }
            
            .mobile-menu-toggle.active span:nth-child(2) {
                opacity: 0;
            }
            
            .mobile-menu-toggle.active span:nth-child(3) {
                transform: rotate(45deg) translate(-5px, -6px);
            }
        }

        /* Mobile styles */
        @media (max-width: 768px) {
            .container {
                padding: 0 20px;
            }
            
            .hero {
                min-height: 90vh;
                padding: 100px 0 60px;
            }
            
            .hero-content {
                grid-template-columns: 1fr;
                gap: 3rem;
                text-align: center;
            }

            .hero-text h1 {
                font-size: 2.75rem;
                line-height: 1.2;
            }

            .hero-text p {
                font-size: 1.125rem;
                margin-bottom: 2rem;
            }

            .features-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .hero-buttons {
                justify-content: center;
                flex-direction: column;
                align-items: center;
            }

            .btn-primary, .btn-secondary {
                width: 100%;
                max-width: 320px;
                text-align: center;
                justify-content: center;
            }

            .stats-cards {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .dashboard-preview {
                padding: 1.5rem;
                margin: 0 1rem;
            }

            .stat-value {
                font-size: 1.5rem;
            }

            .chart-area {
                height: 100px;
            }
            
            .section-header h2 {
                font-size: 2rem;
            }
            
            .section-header p {
                font-size: 1rem;
            }
            
            .app-content {
                grid-template-columns: 1fr;
                gap: 3rem;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 1.5rem;
            }
            
            .stat-item h3 {
                font-size: 2rem;
            }
            
            .cta-section h2 {
                font-size: 1.75rem;
            }
            
            .footer-content {
                grid-template-columns: 1fr;
                gap: 2rem;
                text-align: center;
            }
            
            .feature-card {
                padding: 1.5rem;
            }
            
            .features, .mobile-app, .cta-section {
                padding: 60px 0;
            }
            
            .stats {
                padding: 60px 0;
            }
        }

        /* Small mobile styles */
        @media (max-width: 480px) {
            .container {
                padding: 0 15px;
            }
            
            .hero-text h1 {
                font-size: 2.25rem;
                line-height: 1.1;
            }
            
            .hero-text p {
                font-size: 1rem;
            }
            
            .btn-primary, .btn-secondary {
                padding: 14px 24px;
                font-size: 0.9rem;
            }
            
            .dashboard-preview {
                padding: 1rem;
                margin: 0 0.5rem;
            }
            
            .stat-card {
                padding: 1rem;
            }
            
            .stat-value {
                font-size: 1.25rem;
            }
            
            .section-header h2 {
                font-size: 1.75rem;
            }
            
            .feature-card {
                padding: 1.25rem;
            }
            
            .feature-icon {
                font-size: 2rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .stat-item h3 {
                font-size: 1.75rem;
            }
            
            .cta-section h2 {
                font-size: 1.5rem;
            }
            
            .cta-section p {
                font-size: 1rem;
            }
        }

        /* Very small screens */
        @media (max-width: 320px) {
            .hero-text h1 {
                font-size: 2rem;
            }
            
            .dashboard-preview {
                margin: 0;
            }
            
            .stats-cards {
                gap: 0.75rem;
            }
            
            .chart-area {
                height: 80px;
            }
        }

        /* Landscape mobile styles */
        @media (max-height: 500px) and (orientation: landscape) {
            .hero {
                min-height: auto;
                padding: 120px 0 40px;
            }
            
            .hero-content {
                gap: 2rem;
            }
            
            .hero-text h1 {
                font-size: 2.5rem;
                margin-bottom: 1rem;
            }
            
            .hero-text p {
                margin-bottom: 1.5rem;
            }
        }

        /* Print styles */
        @media print {
            .hero, .cta-section {
                break-inside: avoid;
            }
            
            .nav-links, .mobile-menu-toggle, .hero-buttons {
                display: none;
            }
            
            .hero-text h1 {
                color: #000 !important;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .feature-card {
            animation: fadeInUp 0.6s ease forwards;
        }

        .feature-card:nth-child(1) { animation-delay: 0.1s; }
        .feature-card:nth-child(2) { animation-delay: 0.2s; }
        .feature-card:nth-child(3) { animation-delay: 0.3s; }
        .feature-card:nth-child(4) { animation-delay: 0.4s; }
        .feature-card:nth-child(5) { animation-delay: 0.5s; }
        .feature-card:nth-child(6) { animation-delay: 0.6s; }

        .dashboard-preview {
            animation: fadeInUp 0.8s ease 0.3s both;
        }

        /* Mobile Menu Toggle */
        .mobile-menu-toggle {
            display: none;
            flex-direction: column;
            cursor: pointer;
            padding: 8px;
        }

        .mobile-menu-toggle span {
            width: 25px;
            height: 3px;
            background: #64748b;
            margin: 3px 0;
            transition: 0.3s;
        }

        @media (max-width: 768px) {
            .mobile-menu-toggle {
                display: flex;
            }
        }
    </style>
</head>
<body>
    <header>
        <nav class="container">
            <div class="logo">CHSHub</div>
            <ul class="nav-links">
                <li><a href="#features">Features</a></li>
                <li><a href="#mobile">Mobile App</a></li>
                <li><a href="#contact">Contact</a></li>
                <li><a href="login1.aspx" style="color:white" class="cta-button">Login</a></li>
            </ul>
            <div class="mobile-menu-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </nav>
    </header>

    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <div class="hero-text">
                    <h1>Modern <span class="highlight">Society Management</span> Made Simple</h1>
                    <p>Streamline your cooperative housing society operations with our comprehensive digital platform. Manage payments, track expenses, handle member communications, and much more.</p>
                    <div class="hero-buttons">
                        <a href="https://chs.vengurlatech.com/" class="btn-primary">
                            Get Started →
                        </a>
                        <a href="#features" class="btn-secondary">Learn More</a>
                    </div>
                </div>
                <div class="hero-visual">
                    <div class="dashboard-preview">
                        <div class="dashboard-header">
                            <div class="dashboard-icon">📊</div>
                            <div class="dashboard-title">Society Dashboard</div>
                        </div>
                        
                        <div class="stats-cards">
                            <div class="stat-card due-payments">
                                <div class="stat-value">₹84.8k</div>
                                <div class="stat-label">Due Payments</div>
                            </div>
                            <div class="stat-card defaulters">
                                <div class="stat-value">0</div>
                                <div class="stat-label">Defaulters</div>
                            </div>
                            <div class="stat-card members">
                                <div class="stat-value">25</div>
                                <div class="stat-label">Total Members</div>
                            </div>
                            <div class="stat-card income">
                                <div class="stat-value">₹2.1L</div>
                                <div class="stat-label">Monthly Income</div>
                            </div>
                        </div>
                        
                        <div class="chart-area">
                            <div class="chart-placeholder">
                                <span>📈</span>
                                <span>Expense Analytics</span>
                            </div>
                            <div class="chart-bars">
                                <div class="chart-bar"></div>
                                <div class="chart-bar"></div>
                                <div class="chart-bar"></div>
                                <div class="chart-bar"></div>
                                <div class="chart-bar"></div>
                                <div class="chart-bar"></div>
                                <div class="chart-bar"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="stats">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item">
                    <h3>10+</h3>
                    <p>Societies Managed</p>
                </div>
                <div class="stat-item">
                    <h3>100+</h3>
                    <p>Active Members</p>
                </div>
                <div class="stat-item">
                    <h3>₹50L+</h3>
                    <p>Payments Processed</p>
                </div>
                <div class="stat-item">
                    <h3>99.9%</h3>
                    <p>Uptime Guaranteed</p>
                </div>
            </div>
        </div>
    </section>

    <section class="features" id="features">
        <div class="container">
            <div class="section-header">
                <h2>Complete Society Management Solution</h2>
                <p>Everything you need to run your cooperative housing society efficiently and transparently</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">💰</div>
                    <h3>Payment Management</h3>
                    <p>Track maintenance payments, generate receipts, and monitor due amounts with automated reminders and penalty calculations.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">👥</div>
                    <h3>Member Management</h3>
                    <p>Maintain comprehensive member profiles, track ownership details, and manage member communications efficiently.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Expense Tracking</h3>
                    <p>Monitor society expenses, categorize costs, and generate detailed financial reports with visual analytics.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔧</div>
                    <h3>Maintenance Requests</h3>
                    <p>Handle shop maintenance and ownership maintenance requests with priority tracking and status updates.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h3>Mobile Application</h3>
                    <p>Dedicated mobile app for society members to make payments, submit requests, and stay updated with society activities.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📈</div>
                    <h3>Advanced Analytics</h3>
                    <p>Comprehensive reports and analytics to help committee members make informed decisions about society operations.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="mobile-app" id="mobile">
        <div class="container">
            <div class="app-content">
                <div>
                    <h2 style="font-size: 2.25rem; font-weight: 700; color: #1a202c; margin-bottom: 1rem;">Mobile App for Society Members</h2>
                    <p style="font-size: 1.125rem; color: #64748b; margin-bottom: 2rem;">Give your society members the convenience of managing everything from their smartphones</p>
                    
                    <ul class="app-features">
                        <li>Make maintenance payments securely</li>
                        <li>View payment history and receipts</li>
                        <li>Submit maintenance requests</li>
                        <li>Receive important society notifications</li>
                        <li>Access society documents and notices</li>
                        <li>Chat with society management</li>
                    </ul>
                    
                    <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                        <a href="#" class="btn-primary">📱 Download App</a>
                    </div>
                </div>
                <div style="text-align: center;">
                    <div style="background: white; padding: 2rem; border-radius: 16px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1); border: 1px solid #e2e8f0; display: inline-block;">
                        <div style="font-size: 6rem;">📱</div>
                        <h3 style="color: #1a202c; margin-top: 1rem; font-weight: 600;">Society App</h3>
                        <p style="color: #64748b; font-size: 0.9rem;">Available for iOS & Android</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="cta-section">
        <div class="container">
            <h2>Ready to Transform Your Society Management?</h2>
            <p>Join hundreds of societies already using our platform to streamline their operations</p>
            <a href="https://chs.vengurlatech.com/" class="btn-primary">Start Your Free Trial</a>
        </div>
    </section>

    <footer id="contact">
        <div class="container">
            <div class="footer-content" style="display: flex; justify-content: space-between; gap: 20px;">
                <div class="footer-section" style="flex: 1;">
                    <h3>VengurlatTech</h3>
                    <p>Modern society management system designed for cooperative housing societies.</p>
                </div>
                <div class="footer-section" style="flex: 1;">
                    <h3>Quick Links</h3>
                    <p><a href="#features">Features</a></p>
                    <p><a href="#mobile">Mobile App</a></p>
                    <p><a href="t_n_c.aspx">Terms and Conditions</a></p>
                    <p><a href="https://chs.vengurlatech.com/">Login Portal</a></p>
                </div>
                <div class="footer-section" style="flex: 1;">
                    <h3>Contact Us</h3>
                    <p>VengurlatTech Pvt Ltd</p>
                    <p>Vengurla, Maharashtra</p>
                    <p>support@vengurlattech.com</p>
                </div>
            </div>
            <div style="border-top: 1px solid #475569; padding-top: 2rem; text-align: center; color: #94a3b8;">
                <p>&copy; 2024 VengurlatTech Pvt Ltd. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Mobile menu toggle functionality
        const mobileToggle = document.querySelector('.mobile-menu-toggle');
        const navLinks = document.querySelector('.nav-links');

        if (mobileToggle && navLinks) {
            mobileToggle.addEventListener('click', function () {
                navLinks.classList.toggle('active');
                this.classList.toggle('active');
            });
        }

        // Header background on scroll
        window.addEventListener('scroll', function () {
            const header = document.querySelector('header');
            if (window.scrollY > 100) {
                header.style.background = 'rgba(248, 250, 252, 0.98)';
                header.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.08)';
            } else {
                header.style.background = 'rgba(248, 250, 252, 0.95)';
                header.style.boxShadow = '0 1px 3px rgba(0, 0, 0, 0.05)';
            }
        });

        // Counter animation for stats
        function animateCounters() {
            const counters = document.querySelectorAll('.stat-item h3');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const target = entry.target;
                        const text = target.textContent;
                        const number = parseInt(text.replace(/[^\d]/g, ''));

                        if (number > 0) {
                            let current = 0;
                            const increment = number / 50;
                            const timer = setInterval(() => {
                                current += increment;
                                if (current >= number) {
                                    target.textContent = text;
                                    clearInterval(timer);
                                } else {
                                    const suffix = text.includes('+') ? '+' : (text.includes('%') ? '%' : '');
                                    const prefix = text.includes('₹') ? '₹' : '';
                                    target.textContent = prefix + Math.floor(current) + (text.includes('L') ? 'L' : '') + (text.includes('k') ? 'k' : '') + suffix;
                                }
                            }, 50);
                        }
                        observer.unobserve(target);
                    }
                });
            });

            counters.forEach(counter => observer.observe(counter));
        }

        // Initialize animations when page loads
        document.addEventListener('DOMContentLoaded', function () {
            animateCounters();
        });

        // Add loading animation
        window.addEventListener('load', function () {
            document.body.classList.add('loaded');
        });
    </script>
</body>
</html>
