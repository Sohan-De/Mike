
/**
 * Interactive behaviors for the static website.
 * Recreates the mobile navigation drawer using the site's distinct branding and design system.
 */
document.addEventListener('DOMContentLoaded', function () {

    // ==========================================
    // GLOBAL HELPERS: Devis / Diagnostic Navigation & Validation
    // ==========================================

    /**
     * Validates email format using a standard regex.
     */
    function isValidEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    /**
     * Tries to find the "Diagnostic" section and scroll to it.
     * Returns true if found and scrolled, false otherwise.
     */
    function scrollToDiagnostic() {
        // Target the specific gradient section "Votre devis gratuit en 2 minutes"
        // This selector matches the specific section in index.html
        const target = document.querySelector('section.bg-gradient-to-br.from-blue-50.to-green-50');
        if (target) {
            target.scrollIntoView({ behavior: 'smooth' });
            return true;
        }
        return false;
    }

    /**
     * Handles clicks on any "Devis" related button
     */
    function handleDevisClick(e) {
        // 1. Close mobile menu if open (by clicking the overlay if visible)
        const overlay = document.querySelector('.fixed.inset-x-0.bottom-0.bg-transparent');
        if (overlay && overlay.style.pointerEvents === 'auto') {
            overlay.click();
        }

        // 2. Try to scroll to section on current page
        e.preventDefault();
        if (!scrollToDiagnostic()) {
            // 3. If section not found (we are on another page), go to index
            window.location.href = '/index.html#diagnostic';
        }
    }

    // CHECK ON LOAD: If URL has #diagnostic, scroll to it
    if (window.location.hash === '#diagnostic') {
        setTimeout(scrollToDiagnostic, 300); // Slight delay for layout stability
    }

    // APPLY TO ALL EXISTING LINKS (Desktop & Mobile)
    // We target links containing "Devis" text or specifically linking to the old form page
    document.querySelectorAll('a').forEach(link => {
        const text = (link.textContent || '').toLowerCase();
        const href = (link.getAttribute('href') || '');

        if (text.includes('devis') || text.includes('décrire la situation')) {
            // Attach our smart handler
            link.addEventListener('click', handleDevisClick);
        }
    });

    // ==========================================
    // MOBILE NAVIGATION DRAWER
    // ==========================================
    const menuButton = document.querySelector('div.md\\:hidden button') || document.querySelector('button[aria-label="Ouvrir le menu principal"]');

    if (menuButton) {
        // 1. Create the Overlay (Backdrop)
        const overlay = document.createElement('div');
        overlay.className = 'fixed inset-x-0 bottom-0 bg-transparent transition-opacity duration-300 pointer-events-none';
        overlay.style.top = '80px';
        overlay.style.zIndex = '48';

        // 2. Create the Drawer (Menu Container)
        const drawer = document.createElement('div');
        drawer.className = 'fixed inset-x-0 bg-white/95 backdrop-blur-xl shadow-futur border-b border-brand-royal-blue/10 flex flex-col p-6 rounded-b-3xl';

        // Custom Smooth Transition
        drawer.style.transition = 'transform 0.6s cubic-bezier(0.16, 1, 0.3, 1)';

        // Layout Properties
        drawer.style.zIndex = '49';
        drawer.style.top = '80px';
        drawer.style.height = '80vh';
        drawer.style.transform = 'translateY(-100%)';

        // 3. Navigation Links Container
        const linksContainer = document.createElement('nav');
        linksContainer.className = 'flex flex-col space-y-4 overflow-y-auto flex-1 pt-4';

        // Clone links from desktopNav
        const desktopNav = document.querySelector('nav.hidden.md\\:flex');
        if (desktopNav) {
            const originalLinks = desktopNav.querySelectorAll('a');
            originalLinks.forEach(link => {
                const mobileLink = document.createElement('a');
                mobileLink.href = link.href;
                mobileLink.textContent = link.textContent;
                mobileLink.className = 'text-xl font-bold text-brand-anthracite hover:text-brand-royal-blue transition-colors block border-b border-brand-royal-blue/5 pb-3';
                linksContainer.appendChild(mobileLink);
            });
        }

        // 5. Badges Section
        const badgesContainer = document.createElement('div');
        badgesContainer.className = 'flex flex-wrap gap-3 justify-center py-4';

        const badge1 = document.createElement('div');
        badge1.className = 'flex items-center space-x-1 bg-green-50 px-3 py-1.5 rounded-full border border-green-200';
        badge1.innerHTML = `
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-green-600">
                <path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"></path>
            </svg>
            <span class="text-xs font-medium text-green-800">Garantie 10ans</span>
        `;

        const badge2 = document.createElement('div');
        badge2.className = 'flex items-center space-x-1 bg-blue-50 px-3 py-1.5 rounded-full border border-blue-200';
        badge2.innerHTML = `
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-blue-600">
                <path d="m15.477 12.89 1.515 8.526a.5.5 0 0 1-.81.47l-3.58-2.687a1 1 0 0 0-1.197 0l-3.586 2.686a.5.5 0 0 1-.81-.469l1.514-8.526"></path>
                <circle cx="12" cy="8" r="6"></circle>
            </svg>
            <span class="text-xs font-medium text-blue-800">40+ avis Google</span>
        `;

        badgesContainer.appendChild(badge1);
        badgesContainer.appendChild(badge2);

        // 6. CTA Container
        const ctaContainer = document.createElement('div');
        ctaContainer.className = 'mt-8 flex flex-col space-y-3 pb-6';

        // Phone Button
        const phoneBtn = document.createElement('a');
        phoneBtn.href = 'tel:+33780971996';
        phoneBtn.className = 'btn-phone shadow-lg justify-center w-full';
        phoneBtn.innerHTML = `
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2">
                <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
            </svg>
            07 80 97 19 96
        `;

        // Quote Button - In Drawer
        const quoteBtn = document.createElement('a');
        quoteBtn.href = 'index.html#diagnostic'; // Semantically correct
        quoteBtn.className = 'btn-primary justify-center w-full';
        quoteBtn.textContent = 'Devis Gratuit';

        // Apply SMART Handler
        quoteBtn.addEventListener('click', handleDevisClick);

        ctaContainer.appendChild(phoneBtn);
        ctaContainer.appendChild(quoteBtn);

        // Assemble drawer
        // Order: Badges -> Links -> CTA
        drawer.appendChild(badgesContainer);
        drawer.appendChild(linksContainer);
        drawer.appendChild(ctaContainer);

        // Append to body
        document.body.appendChild(overlay);
        document.body.appendChild(drawer);

        // --- Interactions ---
        let isOpen = false;

        function openMenu() {
            // Show overlay
            overlay.style.pointerEvents = 'auto';
            overlay.style.opacity = '1';

            // Slide Down Drawer
            drawer.style.transform = 'translateY(0)';
            isOpen = true;
        }

        function closeMenu() {
            // Hide overlay
            overlay.style.pointerEvents = 'none';
            overlay.style.opacity = '0';

            // Slide Up Drawer
            drawer.style.transform = 'translateY(-100%)';
            isOpen = false;
        }

        // Toggle logic for the main button
        menuButton.addEventListener('click', (e) => {
            e.preventDefault();
            if (isOpen) {
                closeMenu();
            } else {
                openMenu();
            }
        });

        overlay.addEventListener('click', closeMenu);

        // Close on link click
        drawer.querySelectorAll('a').forEach(link => {
            // NOTE: We don't want to double-bind handleDevisClick, but it's safe due to closeMenu logic
            // However, general links should just close menu
            link.addEventListener('click', (e) => {
                // For devis links, handleDevisClick is already attached and will run.
                // We just ensure closeMenu is called.
                closeMenu();
            });
        });
    }

    // ==========================================
    // CAROUSEL LOGIC
    // ==========================================
    const carousels = document.querySelectorAll('[role="region"][aria-roledescription="carousel"]');
    carousels.forEach(carousel => {
        const track = carousel.querySelector('.flex');
        const buttons = carousel.querySelectorAll('button');
        let prevBtn = null;
        let nextBtn = null;

        buttons.forEach(btn => {
            const srText = btn.textContent || "";
            if (srText.includes('Previous') || srText.includes('Précédent')) prevBtn = btn;
            if (srText.includes('Next') || srText.includes('Suivant')) nextBtn = btn;
        });

        if (track && prevBtn && nextBtn) {
            let currentScroll = 0;

            prevBtn.addEventListener('click', () => {
                const cardWidth = track.firstElementChild ? track.firstElementChild.offsetWidth : 300;
                currentScroll = Math.max(currentScroll - cardWidth, 0);
                track.style.transform = `translate3d(-${currentScroll}px, 0px, 0px)`;
            });

            nextBtn.addEventListener('click', () => {
                const cardWidth = track.firstElementChild ? track.firstElementChild.offsetWidth : 300;
                const maxScroll = track.scrollWidth - track.clientWidth;
                currentScroll = Math.min(currentScroll + cardWidth, maxScroll);
                track.style.transform = `translate3d(-${currentScroll}px, 0px, 0px)`;
            });
        }
    });

    // ==========================================
    // DIAGNOSTIC FORM LOGIC (EmailJS Integ.)
    // ==========================================
    (function initDiagnosticForm() {
        const btnNext = document.getElementById('btn-diag-next');
        const btnBack = document.getElementById('btn-diag-back');
        const btnSubmit = document.getElementById('btn-diag-submit');

        // Only run if elements exist
        if (!btnNext) return;

        const step1 = document.getElementById('diag-step-1');
        const step2 = document.getElementById('diag-step-2');
        const successStep = document.getElementById('diag-success');

        const inputAge = document.getElementById('diag-age');
        const inputType = document.getElementById('diag-type');
        const inputInspection = document.getElementById('diag-inspection');
        const inputSurface = document.getElementById('diag-surface');

        const inputName = document.getElementById('diag-name');
        const inputEmail = document.getElementById('diag-email');
        const inputPhone = document.getElementById('diag-phone');
        const inputMessage = document.getElementById('diag-message');

        // Navigation
        btnNext.addEventListener('click', () => {
            let valid = true;
            [inputAge, inputType, inputInspection].forEach(el => {
                if (!el.value) {
                    el.classList.add('border-red-500');
                    valid = false;
                } else {
                    el.classList.remove('border-red-500');
                }
            });

            if (valid) {
                step1.classList.add('hidden');
                step2.classList.remove('hidden');
            }
        });

        btnBack.addEventListener('click', () => {
            step2.classList.add('hidden');
            step1.classList.remove('hidden');
        });

        // Submission
        btnSubmit.addEventListener('click', () => {
            let valid = true;
            // Simple required check
            [inputName, inputEmail, inputPhone].forEach(el => {
                if (!el.value) {
                    el.classList.add('border-red-500');
                    valid = false;
                } else {
                    el.classList.remove('border-red-500');
                }
            });

            // Email format check
            if (inputEmail.value && !isValidEmail(inputEmail.value)) {
                inputEmail.classList.add('border-red-500');
                valid = false;
            }

            if (!valid) return;

            // Loading state
            const originalText = btnSubmit.innerHTML;
            btnSubmit.disabled = true;
            btnSubmit.innerHTML = 'Envoi en cours...';

            // Prepare Message
            const diagnosticDetails = `
DIAGNOSTIC TOITURE:
- Age: ${inputAge.value}
- Type: ${inputType.value}
- Inspection: ${inputInspection.value}
- Surface: ${inputSurface.value || 'Non renseignée'} m²

MESSAGE CLIENT:
${inputMessage.value}
             `.trim();

            const params = {
                to_email: 'futurtoiture1@gmail.com',
                website_url: window.location.href,
                name: inputName.value,
                email: inputEmail.value,
                phone: inputPhone.value,
                message: diagnosticDetails
            };

            // Send via EmailJS (User provided IDs)
            emailjs.send('service_qf2d3nm', 'template_rroz60a', params)
                .then(() => {
                    step2.classList.add('hidden');
                    successStep.classList.remove('hidden');
                    btnSubmit.innerHTML = originalText;
                })
                .catch((err) => {
                    console.error('EmailJS Error:', err);
                    alert("Une erreur est survenue lors de l'envoi. Veuillez nous appeler directement.");
                    btnSubmit.disabled = false;
                    btnSubmit.innerHTML = originalText;
                });
        });

    })();


    // ==========================================
    // QUOTE FORM LOGIC (EmailJS Integ.)
    // ==========================================
    (function initQuoteForm() {
        const btnSubmit = document.getElementById('btn-quote-submit');
        if (!btnSubmit) return;

        const formContent = document.getElementById('quote-form-content');
        const successMessage = document.getElementById('quote-success');

        const inputName = document.getElementById('quote-name');
        const inputPhone = document.getElementById('quote-phone');
        const inputEmail = document.getElementById('quote-email');
        const inputMessage = document.getElementById('quote-message');

        btnSubmit.addEventListener('click', () => {
            let valid = true;
            [inputName, inputPhone, inputEmail, inputMessage].forEach(el => {
                if (!el.value) {
                    el.classList.add('border-red-500');
                    valid = false;
                } else {
                    el.classList.remove('border-red-500');
                }
            });

            // Email format check
            if (inputEmail.value && !isValidEmail(inputEmail.value)) {
                inputEmail.classList.add('border-red-500');
                valid = false;
            }

            if (!valid) return;

            const originalText = btnSubmit.innerHTML;
            btnSubmit.disabled = true;
            btnSubmit.innerHTML = 'Envoi en cours...';

            // Prepare Quote Request Message
            const messageBody = `
DEMANDE DE DEVIS (Formulaire Bas de Page):
------------------------------------------
MESSAGE:
${inputMessage.value}
            `.trim();

            const params = {
                to_email: 'futurtoiture1@gmail.com',
                website_url: window.location.href,
                name: inputName.value,
                email: inputEmail.value,
                phone: inputPhone.value,
                message: messageBody
            };

            // Send via EmailJS (Same specific account/template)
            emailjs.send('service_qf2d3nm', 'template_rroz60a', params)
                .then(() => {
                    formContent.classList.add('hidden');
                    successMessage.classList.remove('hidden');
                    // Scroll to success message
                    successMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });
                })
                .catch((err) => {
                    console.error('EmailJS Error:', err);
                    alert("Une erreur est survenue. Contactez-nous par téléphone.");
                    btnSubmit.disabled = false;
                    btnSubmit.innerHTML = originalText;
                });
        });
    })();


    // ==========================================
    // RENOVATION FORM LOGIC (EmailJS Integ.)
    // ==========================================
    (function initRenovationForm() {
        const btnSubmit = document.getElementById('btn-renovation-submit');
        if (!btnSubmit) return;

        const formContent = document.getElementById('renovation-form-content');
        const successMessage = document.getElementById('renovation-success');

        const inputName = document.getElementById('renovation-name');
        const inputPhone = document.getElementById('renovation-phone');
        const inputEmail = document.getElementById('renovation-email');
        const inputMessage = document.getElementById('renovation-message');

        btnSubmit.addEventListener('click', () => {
            let valid = true;
            [inputName, inputPhone, inputEmail, inputMessage].forEach(el => {
                if (!el.value) {
                    el.classList.add('border-red-500');
                    valid = false;
                } else {
                    el.classList.remove('border-red-500');
                }
            });

            // Email format check
            if (inputEmail.value && !isValidEmail(inputEmail.value)) {
                inputEmail.classList.add('border-red-500');
                valid = false;
            }

            if (!valid) return;

            const originalText = btnSubmit.innerHTML;
            btnSubmit.disabled = true;
            btnSubmit.innerHTML = 'Envoi en cours...';

            const messageBody = `
DEMANDE DE DEVIS RÉNOVATION:
------------------------------------------
MESSAGE:
${inputMessage.value}
            `.trim();

            const params = {
                to_email: 'futurtoiture1@gmail.com',
                website_url: window.location.href,
                name: inputName.value,
                email: inputEmail.value,
                phone: inputPhone.value,
                message: messageBody
            };

            emailjs.send('service_qf2d3nm', 'template_rroz60a', params)
                .then(() => {
                    formContent.classList.add('hidden');
                    successMessage.classList.remove('hidden');
                    successMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });
                })
                .catch((err) => {
                    console.error('EmailJS Error:', err);
                    alert("Une erreur est survenue. Contactez-nous par téléphone.");
                    btnSubmit.disabled = false;
                    btnSubmit.innerHTML = originalText;
                });
        });
    })();


    // ==========================================
    // URGENCE FORM LOGIC (EmailJS Integ.)
    // ==========================================
    (function initUrgenceForm() {
        const btnSubmit = document.getElementById('btn-urgence-submit');
        if (!btnSubmit) return;

        const formContent = document.getElementById('urgence-form-content');
        const successMessage = document.getElementById('urgence-success');

        const inputName = document.getElementById('urgence-name');
        const inputPhone = document.getElementById('urgence-phone');
        const inputEmail = document.getElementById('urgence-email');
        const inputMessage = document.getElementById('urgence-message');

        btnSubmit.addEventListener('click', () => {
            let valid = true;
            [inputName, inputPhone, inputEmail, inputMessage].forEach(el => {
                if (!el.value) {
                    el.classList.add('border-red-500');
                    valid = false;
                } else {
                    el.classList.remove('border-red-500');
                }
            });

            // Email format check
            if (inputEmail.value && !isValidEmail(inputEmail.value)) {
                inputEmail.classList.add('border-red-500');
                valid = false;
            }

            if (!valid) return;

            const originalText = btnSubmit.innerHTML;
            btnSubmit.disabled = true;
            btnSubmit.innerHTML = 'Envoi en cours...';

            const messageBody = `
🚨 DEMANDE D'INTERVENTION URGENTE:
------------------------------------------
DESCRIPTION DE L'URGENCE:
${inputMessage.value}
            `.trim();

            const params = {
                to_email: 'futurtoiture1@gmail.com',
                website_url: window.location.href,
                name: inputName.value,
                email: inputEmail.value,
                phone: inputPhone.value,
                message: messageBody
            };

            emailjs.send('service_qf2d3nm', 'template_rroz60a', params)
                .then(() => {
                    formContent.classList.add('hidden');
                    successMessage.classList.remove('hidden');
                    successMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });
                })
                .catch((err) => {
                    console.error('EmailJS Error:', err);
                    alert("Une erreur est survenue. Contactez-nous par téléphone.");
                    btnSubmit.disabled = false;
                    btnSubmit.innerHTML = originalText;
                });
        });
    })();


    // ==========================================
    // SERVICES FORM LOGIC (EmailJS Integ.)
    // ==========================================
    (function initServicesForm() {
        const btnSubmit = document.getElementById('btn-services-submit');
        if (!btnSubmit) return;

        const formContent = document.getElementById('services-form-content');
        const successMessage = document.getElementById('services-success');

        const inputName = document.getElementById('services-name');
        const inputPhone = document.getElementById('services-phone');
        const inputEmail = document.getElementById('services-email');
        const inputMessage = document.getElementById('services-message');

        btnSubmit.addEventListener('click', () => {
            let valid = true;
            [inputName, inputPhone, inputEmail, inputMessage].forEach(el => {
                if (!el.value) {
                    el.classList.add('border-red-500');
                    valid = false;
                } else {
                    el.classList.remove('border-red-500');
                }
            });

            // Email format check
            if (inputEmail.value && !isValidEmail(inputEmail.value)) {
                inputEmail.classList.add('border-red-500');
                valid = false;
            }

            if (!valid) return;

            const originalText = btnSubmit.innerHTML;
            btnSubmit.disabled = true;
            btnSubmit.innerHTML = 'Envoi en cours...';

            const messageBody = `
DEMANDE DE DEVIS - AUTRES SERVICES:
------------------------------------------
MESSAGE:
${inputMessage.value}
            `.trim();

            const params = {
                to_email: 'futurtoiture1@gmail.com',
                website_url: window.location.href,
                name: inputName.value,
                email: inputEmail.value,
                phone: inputPhone.value,
                message: messageBody
            };

            emailjs.send('service_qf2d3nm', 'template_rroz60a', params)
                .then(() => {
                    formContent.classList.add('hidden');
                    successMessage.classList.remove('hidden');
                    successMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });
                })
                .catch((err) => {
                    console.error('EmailJS Error:', err);
                    alert("Une erreur est survenue. Contactez-nous par téléphone.");
                    btnSubmit.disabled = false;
                    btnSubmit.innerHTML = originalText;
                });
        });
    })();

});
