/* CSS Variables for Design System */
:root {
    /* Primary Color - Main Brand Identity */
    --primary-color: #605F4B;
    --primary-hover: #4F4E3D;

    /* Secondary Colors - Backgrounds & Sections */
    --secondary-color: #F9F4EA;
    --secondary-sand: #CDAD85;
    --secondary-sage: #9C9E80;

    /* Accent Colors - CTAs & Highlights */
    --accent-terracotta: #C47457;
    --accent-terracotta-hover: #A65D44;
    --accent-copper: #B68036;

    /* Text Colors */
    --text-primary: #605F4B;
    --text-secondary: #6B6A58;
    --text-light: #9C9E80;

    /* Backgrounds */
    --background: #F9F4EA;
    --card-background: #FFFFFF;

    /* Shadows & Effects */
    --shadow-sm: 0 2px 8px rgba(96, 95, 75, 0.08);
    --shadow-md: 0 4px 16px rgba(96, 95, 75, 0.12);
    --shadow-lg: 0 8px 32px rgba(96, 95, 75, 0.16);

    /* Border Radius */
    --border-radius-sm: 8px;
    --border-radius-md: 16px;
    --border-radius-lg: 24px;

    /* Transitions */
    --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Global Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Cairo', sans-serif;
    background: linear-gradient(135deg, var(--background) 0%, #EDE7D9 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    color: var(--text-primary);
    line-height: 1.8;
}

/* Container */
.container {
    width: 100%;
    max-width: 600px;
    margin: 0 auto;
}

/* Card */
.card {
    background: var(--card-background);
    border-radius: var(--border-radius-lg);
    box-shadow: var(--shadow-lg);
    padding: 40px;
    transition: var(--transition);
    position: relative;
    overflow: hidden;
}

.card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--accent-terracotta), var(--accent-copper));
}

.card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
}

/* Back Button */
.back-button {
    position: absolute;
    top: 20px;
    right: 20px;
    width: 40px;
    height: 40px;
    background: white;
    border: none;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    box-shadow: var(--shadow-md);
    color: var(--text-primary);
    transition: var(--transition);
    z-index: 100;
}

.back-button:hover {
    transform: scale(1.1);
    box-shadow: var(--shadow-lg);
    background: var(--secondary-color);
}

.back-button:active {
    transform: scale(0.95);
}

/* Image Container */
.image-container {
    width: 100%;
    height: 200px;
    margin-bottom: 30px;
    border-radius: var(--border-radius-md);
    overflow: hidden;
    position: relative;
    background: linear-gradient(135deg, var(--secondary-sand) 0%, #E5D4B8 100%);
}

/* Image Caption */
.image-caption {
    text-align: right;
    margin-bottom: 25px;
}

.magic-badge {
    display: inline-block;
    padding: 6px 20px;
    background: linear-gradient(135deg, var(--accent-terracotta), var(--accent-copper));
    color: white;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 700;
    font-family: 'Cairo', sans-serif;
    letter-spacing: 0.5px;
}

.main-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: var(--transition);
}

.image-container:hover .main-image {
    transform: scale(1.05);
}

/* Main Title */
.main-title {
    font-size: 24px;
    font-weight: 700;
    color: var(--text-primary);
    margin-bottom: 30px;
    text-align: center;
    line-height: 1.5;
    position: relative;
    padding-bottom: 20px;
}

.main-title::after {
    content: '';
    position: absolute;
    bottom: 0;
    right: 50%;
    transform: translateX(50%);
    width: 60px;
    height: 3px;
    background: linear-gradient(90deg, var(--accent-terracotta), var(--accent-copper));
    border-radius: 2px;
}

/* Info List */
.info-list {
    margin-bottom: 35px;
}

.info-item {
    display: flex;
    align-items: flex-start;
    gap: 15px;
    margin-bottom: 20px;
    padding: 18px;
    background: var(--secondary-color);
    border-radius: var(--border-radius-sm);
    transition: var(--transition);
    position: relative;
    overflow: hidden;
}

.info-item.hidden {
    display: none;
}

.info-item::before {
    content: '';
    position: absolute;
    right: 0;
    top: 0;
    bottom: 0;
    width: 3px;
    background: var(--accent-terracotta);
    transform: scaleY(0);
    transition: var(--transition);
}

.info-item:hover {
    background: #F0E8D8;
    transform: translateX(-5px);
}

.info-item:hover::before {
    transform: scaleY(1);
}

/* Number Badge */
.number {
    min-width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, var(--accent-terracotta), var(--accent-copper));
    color: white;
    border-radius: 50%;
    font-weight: 700;
    font-size: 14px;
    flex-shrink: 0;
    box-shadow: var(--shadow-sm);
    transition: var(--transition);
}

.info-item:hover .number {
    transform: scale(1.1);
    box-shadow: var(--shadow-md);
}

/* Info Text */
.info-item p {
    font-size: 15px;
    color: var(--text-secondary);
    line-height: 1.8;
    margin: 0;
}

/* Knowledge Box */
.knowledge-box {
    margin-bottom: 30px;
    padding: 20px 24px;
    background: linear-gradient(135deg, #FFF5F0 0%, #FFE8DC 100%);
    border-radius: var(--border-radius-md);
    border-right: 4px solid var(--accent-terracotta);
}

.knowledge-header {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 12px;
}

.knowledge-icon {
    font-size: 20px;
}

.knowledge-title {
    font-size: 16px;
    font-weight: 700;
    color: var(--accent-terracotta);
}

.knowledge-text {
    font-size: 14px;
    color: var(--text-secondary);
    line-height: 1.8;
    margin: 0;
}

/* CTA Button */
.cta-button {
    width: 100%;
    padding: 18px 32px;
    background: linear-gradient(135deg, var(--accent-terracotta), var(--accent-copper));
    color: white;
    border: none;
    border-radius: var(--border-radius-sm);
    font-size: 18px;
    font-weight: 700;
    font-family: 'Cairo', sans-serif;
    cursor: pointer;
    box-shadow: var(--shadow-md);
    transition: var(--transition);
    position: relative;
    overflow: hidden;
}

.cta-button::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, var(--accent-copper), var(--accent-terracotta));
    opacity: 0;
    transition: var(--transition);
}

.cta-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(196, 116, 87, 0.4);
}

.cta-button:hover::before {
    opacity: 1;
}

.cta-button:active {
    transform: translateY(0);
}

.cta-button span {
    position: relative;
    z-index: 1;
}

/* Responsive Design */
@media (max-width: 768px) {
    .card {
        padding: 30px 20px;
    }

    .main-title {
        font-size: 20px;
        margin-bottom: 25px;
    }

    .info-item {
        padding: 15px;
    }

    .info-item p {
        font-size: 14px;
    }

    .cta-button {
        font-size: 16px;
        padding: 16px 28px;
    }

    .image-container {
        height: 160px;
    }
}

@media (max-width: 480px) {
    .card {
        padding: 25px 15px;
    }

    .main-title {
        font-size: 18px;
    }

    .number {
        min-width: 28px;
        height: 28px;
        font-size: 13px;
    }
}

/* Animations */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.card {
    animation: fadeIn 0.6s ease-out;
}

.info-item {
    animation: fadeIn 0.6s ease-out backwards;
}

.info-item:nth-child(1) {
    animation-delay: 0.1s;
}

.info-item:nth-child(2) {
    animation-delay: 0.2s;
}

.info-item:nth-child(3) {
    animation-delay: 0.3s;
}

.info-item:nth-child(4) {
    animation-delay: 0.4s;
}