// Interactive enhancements for the health info page

document.addEventListener('DOMContentLoaded', () => {
    // Progressive reveal functionality
    let currentStep = 1;
    const totalSteps = 4;
    const revealButton = document.getElementById('revealButton');
    const knowledgeBox = document.querySelector('.knowledge-box');

    // Hide knowledge box initially
    if (knowledgeBox) {
        knowledgeBox.style.display = 'none';
    }

    if (revealButton) {
        revealButton.addEventListener('click', () => {
            if (currentStep < totalSteps) {
                // Show the next item
                const nextItem = document.querySelector(`.info-item[data-step="${currentStep + 1}"]`);
                if (nextItem) {
                    nextItem.classList.remove('hidden');
                    currentStep++;

                    // Add ripple effect
                    createRipple(revealButton, event);
                }
            }

            // If all steps are revealed, show knowledge box and update button
            if (currentStep >= totalSteps) {
                setTimeout(() => {
                    if (knowledgeBox) {
                        knowledgeBox.style.display = 'block';
                        knowledgeBox.style.animation = 'fadeIn 0.6s ease-out';
                    }
                    revealButton.querySelector('span').textContent = 'تمت القراءة!';
                    revealButton.style.opacity = '0.7';
                    revealButton.style.cursor = 'default';
                    revealButton.disabled = true;
                }, 300);
            }
        });
    }

    // Button click interaction
    const ctaButton = document.querySelector('.cta-button');

    if (ctaButton) {
        // Add span wrapper for text if not exists
        if (!ctaButton.querySelector('span')) {
            ctaButton.innerHTML = `<span>${ctaButton.textContent}</span>`;
        }

        // Click event
        ctaButton.addEventListener('click', () => {
            // Add ripple effect
            createRipple(ctaButton, event);

            // Add pulse animation
            ctaButton.style.animation = 'pulse 0.5s ease-out';
            setTimeout(() => {
                ctaButton.style.animation = '';
            }, 500);
        });
    }

    // Info items hover effect enhancement
    const infoItems = document.querySelectorAll('.info-item');
    infoItems.forEach((item, index) => {
        item.addEventListener('mouseenter', () => {
            item.style.transition = 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)';
        });
    });

    // Intersection Observer for scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe all info items
    infoItems.forEach(item => {
        observer.observe(item);
    });
});

// Ripple effect function
function createRipple(element, event) {
    const ripple = document.createElement('span');
    const rect = element.getBoundingClientRect();
    const size = Math.max(rect.width, rect.height);
    const x = event.clientX - rect.left - size / 2;
    const y = event.clientY - rect.top - size / 2;

    ripple.style.width = ripple.style.height = size + 'px';
    ripple.style.left = x + 'px';
    ripple.style.top = y + 'px';
    ripple.classList.add('ripple');

    // Add ripple styles
    const style = document.createElement('style');
    style.textContent = `
        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.6);
            transform: scale(0);
            animation: ripple-animation 0.6s ease-out;
            pointer-events: none;
        }
        
        @keyframes ripple-animation {
            to {
                transform: scale(2);
                opacity: 0;
            }
        }
        
        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(0.98);
            }
        }
    `;

    if (!document.querySelector('style[data-ripple]')) {
        style.setAttribute('data-ripple', 'true');
        document.head.appendChild(style);
    }

    element.appendChild(ripple);

    setTimeout(() => {
        ripple.remove();
    }, 600);
}

// Add smooth scroll behavior
document.documentElement.style.scrollBehavior = 'smooth';

// Performance optimization: reduce animations on low-end devices
if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    document.querySelectorAll('*').forEach(el => {
        el.style.animation = 'none';
        el.style.transition = 'none';
    });
}
