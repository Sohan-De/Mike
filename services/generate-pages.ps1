# PowerShell script to generate all 12 service pages for Futur Toiture
# With filled/flat SVG icons and side-by-side icon+title layout

$rootPath = $PSScriptRoot

# Filled/flat SVG icon paths (24x24 viewBox, fill-based)
$icons = @{
    shield = '<path d="M12 1 3 5v7c0 6 4 11.5 9 12.5 5-1 9-6.5 9-12.5V5z"/>'
    droplet = '<path d="M12 2C7.5 8 3.5 12.5 3.5 16.5c0 4.7 3.8 8.5 8.5 8.5s8.5-3.8 8.5-8.5C20.5 12.5 16.5 8 12 2z"/>'
    wrench = '<path d="M18 6V4c0-.6-.4-1-1-1h-2c-.6 0-1 .4-1 1v2H3v2h2l3 3v8c0 1.7 1.3 3 3 3h2c1.7 0 3-1.3 3-3v-8l3-3h2V6zm-5 8c0 1.1-.9 2-2 2h-2c-1.1 0-2-.9-2-2v-5l-1.5-1.5h9L13 9v5z"/>'
    home = '<path d="M12 3 2 12h3v9h6v-7h2v7h6v-9h3L12 3z"/>'
    search = '<path d="M15.5 14h-.8l-.3-.3c1-1.1 1.6-2.6 1.6-4.2 0-3.6-2.9-6.5-6.5-6.5S3 5.9 3 9.5 5.9 16 9.5 16c1.6 0 3.1-.6 4.2-1.6l.3.3v.8l5 5 1.5-1.5-5-5zm-6 0C7 14 5 12 5 9.5S7 5 9.5 5 14 7 14 9.5 12 14 9.5 14z"/>'
    document = '<path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8zm-1 2 5 5h-5zM8 13h8v2H8zm0 4h8v2H8zm0-8h3v2H8z"/>'
    'cloud-rain' = '<path d="M19.4 10c-.4-3.8-3.5-6.8-7.4-6.8-3.7 0-6.8 2.8-7.3 6.5C2.3 10 1 11.8 1 14c0 2.8 2.2 5 5 5h13c2.5 0 4.5-2 4.5-4.5 0-2.3-1.7-4.1-3.9-4.5zM7 21l2-3 2 3zm4 0 2-3 2 3z"/>'
    zap = '<path d="M13 2 3 14h6l-1 8 10-12h-6l1-8z"/>'
    pen = '<path d="M3 17.2 12.6 7.6l3.8 3.8L6.8 21H3zm14.7-11.7 3.8 3.8 1.8-1.8c.8-.8.8-2 0-2.8l-1-1c-.8-.8-2-.8-2.8 0z"/>'
    thermometer = '<path d="M12 1 9 5v9c-2.2 0-4 1.8-4 4s1.8 4 4 4 4-1.8 4-4-1.8-4-4-4V5zm-1 13h2v2h-2zm-1 4h4v2h-4z"/>'
    wind = '<path d="M4 9h16v2H4zm0 6h12v2H4zm2-6 3-2v-2H6l-2 1.5zm11 0-3-2V5h3l2 1.5zM8 15l3-2v-2l-3 2zm4 0 3-2v-2l-3 2z"/>'
    'check-circle' = '<path d="M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10 10-4.5 10-10S17.5 2 12 2zm-1.5 14-4-4 1.5-1.5 2.5 2.5 5.5-5.5 1.5 1.5z"/>'
    calendar = '<path d="M19 4h-1V2h-2v2H8V2H6v2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 16H5V10h14v10zm0-12H5V6h14v2zM8 15h2v2H8zm5 0h2v2h-2z"/>'
    mail = '<path d="M22 6c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2zm-2 0-8 5-8-5zm0 12H4V8l8 5 8-5z"/>'
    sun = '<path d="M12 7c-2.8 0-5 2.2-5 5s2.2 5 5 5 5-2.2 5-5-2.2-5-5-5zm0 2c1.7 0 3 1.3 3 3s-1.3 3-3 3-3-1.3-3-3 1.3-3 3-3zM11 1h2v3h-2zm0 19h2v3h-2zM1 11h3v2H1zm19 0h3v2h-3zM4.2 5.6l2.1-2.1 1.4 1.4-2.1 2.1zm12.1 12.1 2.1-2.1 1.4 1.4-2.1 2.1zM5.6 19.8l-2.1-2.1 1.4-1.4 2.1 2.1zm12.1-12.1-2.1-2.1 1.4-1.4 2.1 2.1z"/>'
    camera = '<path d="M20 5h-3.2l-1.6-2H8.8L7.2 5H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V7c0-1.1-.9-2-2-2zm0 14H4V7h4l1.6-2h4.8l1.6 2h4zm-8-3c-2.8 0-5-2.2-5-5s2.2-5 5-5 5 2.2 5 5-2.2 5-5 5zm0-2c1.7 0 3-1.3 3-3s-1.3-3-3-3-3 1.3-3 3 1.3 3 3 3z"/>'
    eye = '<path d="M12 5C7.5 5 3.7 7.9 2 12c1.7 4.1 5.5 7 10 7s8.3-2.9 10-7c-1.7-4.1-5.5-7-10-7zm0 2c3.8 0 7.1 2.4 8.4 5-1.3 2.6-4.6 5-8.4 5s-7.1-2.4-8.4-5c1.3-2.6 4.6-5 8.4-5zm0 2c-1.7 0-3 1.3-3 3s1.3 3 3 3 3-1.3 3-3-1.3-3-3-3zm0 2c.6 0 1 .4 1 1s-.4 1-1 1-1-.4-1-1 .4-1 1-1z"/>'
    flame = '<path d="M12 22c-4.4 0-8-3.6-8-8 0-3.1 1.7-5.8 4.2-7.3.4-.2.8-.1 1.1.3l1.2 1.7c.2.3.7.3 1 0l2.9-4.1c.3-.4 1-.4 1.3 0l2.9 4.1c.2.3.7.3 1 0l1.2-1.7c.3-.4.7-.5 1.1-.3C18.3 8.2 20 10.9 20 14c0 4.4-3.6 8-8 8zm0-2c3.3 0 6-2.7 6-6 0-1.7-.7-3.3-1.9-4.4l-.6.9c-.7 1-2.3 1-3 0l-2.5-3.5-2.5 3.5c-.7 1-2.3 1-3 0l-.6-.9C10.7 10.7 10 12.3 10 14c0 3.3 2.7 6 6 6z"/>'
    scissors = '<path d="M23 6 15 14 8 7l-1.5 1.5c.6.8 1.1 1.8 1.2 2.9L17 21l-2 2-6-6-2.5 2.5c-1.5 1.5-4 1.5-5.5 0S-.5 13.5 1 12s4-1.5 5.5 0l2.5 2.5 4-4-4-4L6.5 9c-1.5 1.5-4 1.5-5.5 0S-.5 3.5 1 2s4-1.5 5.5 0L9 4.5 15 11l2-2H6V7h13l4-4 2 2-6 6 6 6-2 2-4-4-2 2 2 2zm-18 4c-.8.8-.8 2 0 2.8s2 .8 2.8 0 .8-2 0-2.8-2-.8-2.8 0zm0-12c-.8.8-.8 2 0 2.8s2 .8 2.8 0 .8-2 0-2.8-2-.8-2.8 0z"/>'
    scan = '<path d="M4 4h5v2H6v3H4zm11 0h5v5h-2V6h-3zm5 11v5h-5v-2h3v-3zm-16 0v5h5v-2H6v-3zm8-8c-2.2 0-4 1.8-4 4s1.8 4 4 4 4-1.8 4-4-1.8-4-4-4zm0 2c1.1 0 2 .9 2 2s-.9 2-2 2-2-.9-2-2 .9-2 2-2zm0-4v2h2V5h-2zm0 12v2h2v-2zm-5-6h2v2H7zm8 0h2v2h-2z"/>'
}

$services = @(
    @{slug="inspection-toitures"; title="Inspection de Toitures"; titleHtml="Inspection de <span>Toitures</span>"; desc="Diagnostic complet de l'état de votre toiture avec rapport détaillé photographique et recommandations professionnelles. Détection précoce des problèmes pour éviter des réparations coûteuses."; metaDesc="Diagnostic complet de l'état de votre toiture avec rapport détaillé et recommandations professionnelles. Devis gratuit sous 24h. Zone Alès - Gard (30)."; iconSvg=$icons['search']; features=@(@{title="Inspection visuelle complète"; desc="Examen minutieux de chaque tuile, ardoise ou élément de couverture pour détecter fissures, déplacements ou dégradations."; icon=$icons['eye']},@{title="Détection des défauts cachés"; desc="Identification des zones à risque non visibles à l'œil nu grâce à nos outils professionnels et notre expertise terrain."; icon=$icons['scan']},@{title="Rapport photographique détaillé"; desc="Documentation complète avec photos de chaque zone inspectée pour un bilan précis remis à l'issue de l'intervention."; icon=$icons['camera']},@{title="Devis détaillé gratuit"; desc="À la suite de l'inspection, vous recevez un devis précis et transparent pour les travaux nécessaires, sans engagement."; icon=$icons['document']},@{title="Contrôle charpente & structure"; desc="Vérification de l'état de la charpente, des solins, gouttières et tous les éléments structuraux de votre toiture."; icon=$icons['shield']},@{title="Recommandations prioritaires"; desc="Conseils d'expert avec hiérarchisation des interventions selon leur urgence pour optimiser votre budget entretien."; icon=$icons['pen']}); included=@("Inspection visuelle complète de la couverture","Détection des défauts cachés et infiltrations","Rapport photographique détaillé remis sous 48h","Devis détaillé gratuit et sans engagement","Vérification des gouttières et évacuations","Contrôle des solins, faîtage et noues","Évaluation de la charpente et de la structure","Conseils personnalisés et recommandations priorisées")},
    @{slug="installation-toitures"; title="Installation de Toitures"; titleHtml="Installation de <span>Toitures</span>"; desc="Pose complète de toitures neuves avec matériaux de qualité professionnelle et garantie décennale. Charpente traditionnelle ou industrielle, tuiles, ardoises ou zinc."; metaDesc="Installation complète de toitures neuves à Alès. Charpente, couverture tuiles ardoises zinc. Garantie décennale. Devis gratuit."; iconSvg=$icons['home']; features=@(@{title="Charpente traditionnelle ou industrielle"; desc="Pose et remplacement de charpentes en bois massif ou fermettes industrielles selon vos besoins et contraintes architecturales."; icon=$icons['scissors']},@{title="Couverture tuiles, ardoises ou zinc"; desc="Large choix de matériaux de couverture : tuiles terre cuite, ardoises naturelles, zinc ou bac acier selon votre projet et budget."; icon=$icons['home']},@{title="Isolation thermique haute performance"; desc="Intégration d'une isolation thermique performante lors de la pose pour des économies d'énergie durables et un confort optimal."; icon=$icons['thermometer']},@{title="Garantie décennale incluse"; desc="Chaque installation bénéficie de notre garantie décennale obligatoire, vous assurant une tranquillité d'esprit pour les 10 années à venir."; icon=$icons['shield']},@{title="Étanchéité parfaite garantie"; desc="Pose soignée des solins, noues et tous les éléments d'étanchéité pour une toiture imperméable et durable."; icon=$icons['flame']},@{title="Finition soignée & nettoyage"; desc="Chaque chantier se termine par un nettoyage complet du site et une vérification finale de la qualité d'exécution."; icon=$icons['pen']}); included=@("Charpente traditionnelle ou industrielle au choix","Couverture tuiles, ardoises, zinc ou bac acier","Isolation thermique haute performance intégrée","Garantie décennale obligatoire incluse","Étanchéité parfaite solins et noues","Pose des gouttières et évacuations","Nettoyage complet du chantier","Devis détaillé gratuit et sans engagement")},
    @{slug="reparation-toitures"; title="Réparation de Toitures"; titleHtml="Réparation de <span>Toitures</span>"; desc="Réparation rapide et durable de tous types de dommages sur votre toiture. Intervention d'urgence possible 7j/7. Remplacement tuiles, réparation infiltrations, remise en état après intempéries."; metaDesc="Réparation de toiture rapide à Alès. Urgence 7j/7. Tuiles cassées, infiltrations, intempéries. Devis gratuit."; iconSvg=$icons['wrench']; features=@(@{title="Remplacement tuiles cassées"; desc="Remplacement rapide des tuiles fissurées, cassées ou manquantes avec des matériaux identiques ou compatibles."; icon=$icons['wrench']},@{title="Réparation infiltrations d'eau"; desc="Diagnostic précis de la source des infiltrations et traitement durable pour stopper toute entrée d'eau dans votre maison."; icon=$icons['droplet']},@{title="Remise en état après intempéries"; desc="Réparation complète des dommages causés par les tempêtes, grêle, neige ou vents violents. Intervention rapide."; icon=$icons['cloud-rain']},@{title="Intervention d'urgence 7j/7"; desc="Service d'urgence disponible 7 jours sur 7. Nous intervenons rapidement pour limiter les dégâts et protéger votre habitat."; icon=$icons['zap']},@{title="Réparation solins et faîtage"; desc="Remise en état des solins, faîtage, noues et tous les points sensibles de votre toiture pour une étanchéité parfaite."; icon=$icons['shield']},@{title="Devis détaillé gratuit"; desc="Évaluation précise du coût des réparations avant toute intervention. Transparence totale sur les travaux nécessaires."; icon=$icons['document']}); included=@("Remplacement tuiles cassées ou déplacées","Réparation infiltrations et fuites","Remise en état après tempête ou intempéries","Réparation solins, faîtage et noues","Intervention d'urgence 7j/7","Bâchage de protection si nécessaire","Nettoyage complet du chantier","Devis détaillé gratuit et sans engagement")},
    @{slug="installation-gouttieres"; title="Installation de Gouttières"; titleHtml="Installation de <span>Gouttières</span>"; desc="Pose et réparation de gouttières pour une évacuation optimale des eaux pluviales. Gouttières PVC, zinc ou cuivre avec matériaux durables et finitions soignées."; metaDesc="Installation de gouttières à Alès. PVC, zinc, cuivre. Pose professionnelle et étanchéité garantie. Devis gratuit."; iconSvg=$icons['droplet']; features=@(@{title="Gouttières PVC, zinc ou cuivre"; desc="Large choix de matériaux selon votre budget et l'esthétique de votre maison : PVC (économique), zinc (durable) ou cuivre (premium)."; icon=$icons['droplet']},@{title="Descentes d'eaux pluviales"; desc="Installation complète des descentes d'eaux pluviales avec raccordement aux réseaux d'évacuation conformes aux normes en vigueur."; icon=$icons['cloud-rain']},@{title="Crochets de fixation renforcés"; desc="Pose de crochets de fixation en acier inoxydable garantissant une tenue parfaite même par vents forts et chargements neige."; icon=$icons['wrench']},@{title="Étanchéité parfaite garantie"; desc="Joints et raccords parfaitement étanches pour éviter tout débordement ou infiltration. Garantie étanchéité sur nos installations."; icon=$icons['shield']},@{title="Accessoires anti-feuilles"; desc="Pose optionnelle de grilles anti-feuilles pour réduire l'entretien et maintenir vos gouttières fonctionnelles toute l'année."; icon=$icons['wind']},@{title="Garantie et SAV inclus"; desc="Chaque installation est couverte par notre garantie. Nous assurons un suivi et service après-vente réactif pour votre tranquillité."; icon=$icons['check-circle']}); included=@("Gouttières PVC, zinc ou cuivre au choix","Descentes d'eaux pluviales complètes","Crochets de fixation en acier inoxydable","Joints et raccords parfaitement étanches","Grilles anti-feuilles optionnelles","Raccordement réseau d'évacuation","Nettoyage complet du chantier","Devis détaillé gratuit et sans engagement")},
    @{slug="installation-velux"; title="Installation de Velux"; titleHtml="Installation de <span>Velux</span>"; desc="Installation de fenêtres de toit Velux pour apporter lumière naturelle et améliorer l'aération de vos combles. Partenaire agréé Velux, installation standard ou sur mesure."; metaDesc="Installation Velux à Alès. Partenaire agréé. Fenêtres de toit standard ou sur mesure. Étanchéité garantie. Devis gratuit."; iconSvg=$icons['sun']; features=@(@{title="Partenaire agréé Velux"; desc="Installateur certifié par Velux, garantissant une pose conforme aux normes fabricant et le maintien de la garantie produit."; icon=$icons['shield']},@{title="Velux standard ou sur mesure"; desc="Choix dans toute la gamme Velux : tailles standard, sur mesure ou à toits plats pour s'adapter à votre configuration de toiture."; icon=$icons['sun']},@{title="Étanchéité parfaite garantie"; desc="Raccord d'étanchéité professionnel autour de chaque fenêtre de toit pour éviter toute infiltration d'eau."; icon=$icons['droplet']},@{title="Motorisation et volets disponibles"; desc="Options motorisation électrique, volets roulants occultants ou pare-soleil pour un confort et une isolation thermique optimaux."; icon=$icons['zap']},@{title="Isolation thermique renforcée"; desc="Intégration d'une isolation périphérique pour éviter les ponts thermiques et optimiser les performances énergétiques."; icon=$icons['thermometer']},@{title="Amélioration du confort"; desc="Lumière naturelle, ventilation naturelle et vue sur le ciel pour transformer vos combles en espace de vie agréable."; icon=$icons['check-circle']}); included=@("Conseil personnalisé sur le choix du modèle","Pose par installateur certifié Velux","Raccord d'étanchéité professionnel","Isolation périphérique anti-ponts thermiques","Options motorisation et volets disponibles","Finition intérieure soignée","Nettoyage complet du chantier","Garantie fabricant Velux maintenue")},
    @{slug="nettoyage-gouttieres"; title="Nettoyage de Gouttières"; titleHtml="Nettoyage de <span>Gouttières</span>"; desc="Entretien régulier de vos gouttières pour éviter les débordements et prolonger leur durée de vie. Désobstruction complète, vérification des fixations et test d'évacuation."; metaDesc="Nettoyage de gouttières à Alès. Désobstruction professionnelle. Entretien annuel disponible. Devis gratuit."; iconSvg=$icons['wind']; features=@(@{title="Désobstruction complète des débris"; desc="Élimination complète des feuilles mortes, mousses, brindilles et tous débris accumulés dans vos gouttières."; icon=$icons['wind']},@{title="Vérification des fixations"; desc="Contrôle et resserrage des crochets et fixations pour assurer la tenue parfaite de vos gouttières sur toute leur longueur."; icon=$icons['wrench']},@{title="Test complet d'évacuation"; desc="Vérification du bon écoulement des eaux pluviales dans toutes les descentes et identification des éventuelles obstructions."; icon=$icons['cloud-rain']},@{title="Contrat d'entretien annuel"; desc="Abonnement annuel pour un entretien régulier de vos gouttières aux périodes clés (automne et printemps). Tarifs préférentiels."; icon=$icons['calendar']},@{title="Traitement anti-mousse"; desc="Application optionnelle d'un traitement anti-mousse et anti-algues pour prolonger la durée de vie de vos gouttières."; icon=$icons['pen']},@{title="Rapport d'état complet"; desc="Bilan de l'état de vos gouttières remis après chaque intervention avec recommandations si des réparations sont nécessaires."; icon=$icons['document']}); included=@("Désobstruction complète des débris et feuilles","Nettoyage haute pression des gouttières","Vérification et resserrage des fixations","Test complet d'évacuation des eaux","Vérification des descentes pluviales","Traitement anti-mousse optionnel","Rapport d'état et recommandations","Contrat d'entretien annuel disponible")},
    @{slug="reparation-dommages-toitures"; title="Réparation de Dommages aux Toitures"; titleHtml="Réparation de <span>Dommages</span>"; desc="Intervention rapide pour réparer tous types de dommages sur votre toiture avec suivi assurance. Évaluation complète des dégâts, réparation d'urgence et remise en état complète garantie."; metaDesc="Réparation dommages toiture à Alès. Urgence, suivi assurance. Évaluation et remise en état. Devis gratuit."; iconSvg=$icons['shield']; features=@(@{title="Évaluation complète des dégâts"; desc="Inspection détaillée de l'ensemble des dommages subis par votre toiture pour établir un diagnostic précis et un plan de réparation."; icon=$icons['search']},@{title="Réparation d'urgence immédiate"; desc="Intervention express dans les meilleurs délais pour stopper l'aggravation des dégâts et protéger l'intérieur de votre habitation."; icon=$icons['zap']},@{title="Remise en état complète"; desc="Réparation durable et complète de tous les éléments endommagés pour retrouver une toiture en parfait état de fonctionnement."; icon=$icons['wrench']},@{title="Suivi dossier assurance inclus"; desc="Accompagnement complet dans vos démarches auprès de votre assurance : rapport technique, chiffrage et suivi du dossier sinistre."; icon=$icons['shield']},@{title="Bâchage de protection"; desc="Mise en place rapide d'une bâche de protection pour éviter que les intempéries n'aggravent les dégâts dans l'attente des réparations."; icon=$icons['mail']},@{title="Rapport technique détaillé"; desc="Document technique complet listant tous les dommages constatés, les travaux réalisés et les matériaux utilisés pour vos archives."; icon=$icons['document']}); included=@("Évaluation complète et détaillée des dégâts","Bâchage de protection immédiat si nécessaire","Réparation d'urgence 7j/7","Remise en état complète et durable","Suivi complet du dossier assurance","Rapport technique pour votre assureur","Expertise et chiffrage des dommages","Garantie sur les réparations effectuées")},
    @{slug="reparation-gouttieres"; title="Réparation de Gouttières"; titleHtml="Réparation de <span>Gouttières</span>"; desc="Réparation et remise en état de vos gouttières endommagées avec techniques professionnelles. Soudure, colmatage, remplacement de tronçons abîmés. Garantie étanchéité 3 ans."; metaDesc="Réparation de gouttières à Alès. Soudure, colmatage, remplacement. Garantie étanchéité 3 ans. Devis gratuit."; iconSvg=$icons['zap']; features=@(@{title="Soudure et colmatage étanche"; desc="Réparation des fuites et fissures par soudure ou colmatage professionnel avec produits d'étanchéité haute durabilité."; icon=$icons['wrench']},@{title="Remplacement de tronçons abîmés"; desc="Remplacement partiel ou total des sections de gouttières fortement endommagées avec des matériaux identiques pour une finition parfaite."; icon=$icons['droplet']},@{title="Remise en pente correcte"; desc="Correction de la pente des gouttières pour assurer un écoulement parfait de l'eau et éviter les stagnations et débordements."; icon=$icons['cloud-rain']},@{title="Garantie étanchéité 3 ans"; desc="Toutes nos réparations de gouttières sont garanties étanches pendant 3 ans. Votre satisfaction et tranquillité d'esprit avant tout."; icon=$icons['shield']},@{title="Remplacement crochets rouillés"; desc="Remplacement des crochets et fixations corrodés ou défaillants par des crochets en acier inoxydable pour une tenue durable."; icon=$icons['wind']},@{title="Nettoyage après réparation"; desc="Nettoyage complet des gouttières et vérification du bon fonctionnement de l'ensemble du système d'évacuation à l'issue des travaux."; icon=$icons['pen']}); included=@("Diagnostic précis des dommages","Soudure et colmatage professionnel des fuites","Remplacement des tronçons endommagés","Correction de la pente si nécessaire","Remplacement des crochets défaillants","Test d'étanchéité après réparation","Nettoyage complet du chantier","Garantie étanchéité 3 ans sur les réparations")},
    @{slug="reparation-intemperies"; title="Réparation Suite aux Intempéries"; titleHtml="Réparation <span>Après Intempéries</span>"; desc="Spécialiste de la réparation après dommages causés par le vent, grêle ou orage avec intervention rapide. Urgence 24h/7j, bâchage immédiat et expertise assurance gratuite."; metaDesc="Réparation après tempête, grêle, orage à Alès. Intervention d'urgence 24h/7j. Expertise assurance. Devis gratuit."; iconSvg=$icons['cloud-rain']; features=@(@{title="Intervention d'urgence 24h/7j"; desc="Disponibles 24h/24 et 7j/7 pour intervenir rapidement après tout sinistre climatique : tempête, grêle, orage ou neige."; icon=$icons['zap']},@{title="Bâchage de protection immédiat"; desc="Mise en place rapide d'une bâche de protection étanche pour préserver l'intérieur de votre logement dans l'attente des réparations définitives."; icon=$icons['mail']},@{title="Expertise assurance gratuite"; desc="Rédaction d'un rapport technique complet pour votre assurance. Nous vous accompagnons dans toutes vos démarches de déclaration de sinistre."; icon=$icons['shield']},@{title="Remise en état complète garantie"; desc="Réparation complète et durable de tous les éléments endommagés pour retrouver une toiture en parfait état, avec garantie."; icon=$icons['wrench']},@{title="Réparation tempête et grêle"; desc="Traitement de tous types de dommages liés aux intempéries : tuiles arrachées, charpente endommagée, infiltrations post-orage."; icon=$icons['cloud-rain']},@{title="Suivi complet du sinistre"; desc="Accompagnement de A à Z dans votre dossier sinistre : constat, expertise, travaux et réception avec votre assureur."; icon=$icons['document']}); included=@("Intervention d'urgence 24h/7j","Bâchage de protection immédiat","Expertise et rapport pour assurance","Évaluation complète des dommages","Réparation durable de tous les éléments","Remplacement des tuiles arrachées","Réparation charpente si nécessaire","Remise en état complète garantie")},
    @{slug="zinguerie"; title="Travaux de Zinguerie"; titleHtml="Travaux de <span>Zinguerie</span>"; desc="Tous travaux de zinguerie avec façonnage sur mesure : chéneaux, noues, solins, bavettes d'étanchéité. Zinc, cuivre ou acier inoxydable. Soudure à l'étain traditionnelle."; metaDesc="Travaux de zinguerie à Alès. Chéneaux, solins, noues sur mesure. Zinc, cuivre, inox. Soudure traditionnelle. Devis gratuit."; iconSvg=$icons['scissors']; features=@(@{title="Zinc, cuivre, acier inoxydable"; desc="Travail de tous les métaux nobles : zinc naturel ou pré-patiné, cuivre, plomb ou acier inoxydable selon votre projet architectural."; icon=$icons['scissors']},@{title="Soudure à l'étain traditionnelle"; desc="Maîtrise des techniques traditionnelles de soudure à l'étain pour des assemblages parfaitement étanches et durables."; icon=$icons['wrench']},@{title="Façonnage sur mesure en atelier"; desc="Fabrication artisanale sur mesure de tous les éléments de zinguerie dans notre atelier pour un ajustement parfait sur votre toiture."; icon=$icons['pen']},@{title="Étanchéité parfaite garantie"; desc="Pose soignée de tous les éléments d'étanchéité : solins, bavettes, noues et chéneaux pour une protection durable contre les infiltrations."; icon=$icons['shield']},@{title="Chéneaux et noues"; desc="Réalisation et pose de chéneaux encastrés ou de noues en métaux nobles pour un rendu esthétique et une évacuation optimale."; icon=$icons['droplet']},@{title="Solins et bavettes"; desc="Pose de solins en zinc ou plomb autour des cheminées, tabatières, lucarnes et tous points de jonction pour une étanchéité parfaite."; icon=$icons['cloud-rain']}); included=@("Zinc, cuivre ou acier inoxydable au choix","Soudure à l'étain traditionnelle","Façonnage sur mesure en atelier","Pose de chéneaux et noues","Solins autour cheminées et lucarnes","Bavettes et tablettes d'appui","Étanchéité parfaite garantie","Devis détaillé gratuit et sans engagement")},
    @{slug="isolation-toiture"; title="Isolation de Toiture"; titleHtml="Isolation de <span>Toiture</span>"; desc="Amélioration de l'isolation thermique de votre toiture pour réduire vos factures énergétiques et améliorer le confort. Combles perdus, rampants, sarking. Garantie 10 ans."; metaDesc="Isolation de toiture à Alès. Combles perdus, rampants, sarking. Économies d'énergie garanties. Devis gratuit."; iconSvg=$icons['thermometer']; features=@(@{title="Isolation combles perdus"; desc="Soufflage ou déroulage de laine minérale dans vos combles perdus pour une isolation rapide et très efficace avec excellent rapport qualité/prix."; icon=$icons['thermometer']},@{title="Isolation rampants sous toiture"; desc="Isolation de la sous-face des rampants pour les combles aménagés ou aménageables, avec pare-vapeur et finition soignée."; icon=$icons['home']},@{title="Sarking isolation extérieure"; desc="Technique de sarking : isolation thermique posée sur la charpente avant la couverture pour une performance maximale sans pont thermique."; icon=$icons['thermometer']},@{title="Garantie performance thermique 10 ans"; desc="Nos isolations sont garanties pour maintenir leurs performances thermiques pendant 10 ans. Économies d'énergie durables certifiées."; icon=$icons['shield']},@{title="Éligibilité aux aides CEE"; desc="Nous vous accompagnons pour l'obtention des aides à la rénovation énergétique : MaPrimeRénov', CEE et eco-PTZ pour réduire votre investissement."; icon=$icons['zap']},@{title="Bilan thermique offert"; desc="Réalisation d'un bilan thermique gratuit pour identifier les déperditions et dimensionner précisément votre projet d'isolation."; icon=$icons['search']}); included=@("Bilan thermique gratuit","Isolation combles perdus ou rampants","Technique sarking disponible","Pare-vapeur et membranes d'étanchéité","Finition intérieure soignée","Aide à l'obtention des subventions CEE","Garantie performance thermique 10 ans","Devis détaillé gratuit et sans engagement")},
    @{slug="traitement-hydrofuge"; title="Traitement Hydrofuge"; titleHtml="Traitement <span>Hydrofuge</span>"; desc="Nettoyage complet de votre toiture avec traitement hydrofuge professionnel en résine pour prolonger sa durée de vie. Démoussage haute pression, traitement résine coloré ou incolore. Garantie 5 ans."; metaDesc="Traitement hydrofuge toiture à Alès. Démoussage professionnel. Résine colorée ou incolore. Garantie 5 ans. Devis gratuit."; iconSvg=$icons['pen']; features=@(@{title="Démoussage haute pression contrôlée"; desc="Nettoyage professionnel par hydro-gommage à pression contrôlée pour éliminer mousses, lichens et salissures sans endommager les tuiles."; icon=$icons['droplet']},@{title="Traitement résine coloré ou incolore"; desc="Application d'une résine hydrofuge de qualité professionnelle en finition incolore pour un aspect naturel ou colorée pour redonner une nouvelle jeunesse à votre toiture."; icon=$icons['pen']},@{title="Protection optimale des tuiles"; desc="Le traitement hydrofuge crée un film protecteur sur vos tuiles qui repousse l'eau, les mousses et les polluants atmosphériques."; icon=$icons['shield']},@{title="Garantie traitement 5 ans"; desc="Notre traitement hydrofuge professionnel est garanti 5 ans sur l'efficacité imperméabilisante. Protection durable certifiée."; icon=$icons['check-circle']},@{title="Nettoyage gouttières inclus"; desc="Le nettoyage et la vérification des gouttières sont inclus dans notre prestation de traitement pour un entretien global de votre toiture."; icon=$icons['wind']},@{title="Prolongation durée de vie toiture"; desc="Un traitement hydrofuge régulier peut doubler la durée de vie de vos tuiles en les protégeant des cycles gel-dégel et des intempéries."; icon=$icons['zap']}); included=@("Inspection préalable de la toiture","Démoussage haute pression contrôlée","Élimination lichens et mousses","Traitement fongicide anti-repousse","Application résine hydrofuge professionnelle","Nettoyage gouttières inclus","Rapport avant/après photographique","Garantie traitement imperméabilisant 5 ans")}
)

function Generate-Page {
    param($service)
    
    $featuresHtml = ""
    foreach ($f in $service.features) {
        $featuresHtml += @"
      <div class="feature-card">
        <div class="feature-card-header">
          <div class="feature-icon"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor">$($f.icon)</svg></div>
          <h3>$($f.title)</h3>
        </div>
        <p>$($f.desc)</p>
      </div>
"@
    }
    
    $includedHtml = ""
    foreach ($item in $service.included) {
        $includedHtml += @"
      <div class="included-item">
        <svg class="check-icon" xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><path d="M21.801 10A10 10 0 1 1 17 3.335"/><path d="m9 11 3 3L22 4"/></svg>
        <span>$item</span>
      </div>
"@
    }

    return @"
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$($service.title) - Futur Toiture | Expert Couvreur Alès</title>
  <meta name="description" content="$($service.metaDesc)">
  <link rel="icon" href="../favicon.ico" type="image/x-icon">
  <link rel="stylesheet" href="../assets/index-phGN1PUu.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@700;800;900&display=swap" rel="stylesheet">
  <style>
    :root {
      --brand-deep-blue: 228 85% 8%;
      --brand-royal-blue: 218 100% 45%;
      --brand-light-blue: 195 100% 55%;
      --brand-tech-cyan: 180 100% 45%;
      --brand-anthracite: 210 25% 15%;
      --brand-medium-gray: 214 15% 45%;
      --brand-light-gray: 216 20% 97%;
      --futur-gradient-primary: linear-gradient(135deg, hsl(228 85% 8%) 0%, hsl(218 100% 45%) 50%, hsl(195 100% 55%) 100%);
      --futur-gradient-accent: linear-gradient(90deg, hsl(218 100% 45%) 0%, hsl(180 100% 45%) 100%);
      --shadow-glow: 0 0 24px hsl(180 100% 45% / 0.3);
      --shadow-hover: 0 16px 40px -8px hsl(218 100% 45% / 0.25);
    }
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Inter', sans-serif; background: #fff; color: hsl(var(--brand-anthracite)); }
    .service-hero {
      min-height: 480px;
      background: linear-gradient(135deg, hsl(228 85% 8%) 0%, hsl(218 100% 45%) 60%, hsl(180 100% 45%) 100%);
      position: relative; display: flex; align-items: center; overflow: hidden; padding-top: 80px;
    }
    .service-hero::before {
      content: ''; position: absolute; inset: 0;
      background: radial-gradient(ellipse at 70% 50%, hsl(180 100% 45% / 0.18) 0%, transparent 60%),
                  radial-gradient(ellipse at 20% 80%, hsl(218 100% 45% / 0.15) 0%, transparent 50%);
    }
    .service-hero::after {
      content: ''; position: absolute; width: 600px; height: 600px; border-radius: 50%;
      border: 1px solid rgba(255,255,255,0.07); top: -150px; right: -100px;
    }
    .hero-content { position: relative; z-index: 2; max-width: 1440px; margin: 0 auto; padding: 60px 2rem; text-align: center; }
    .hero-badge {
      display: inline-flex; align-items: center; gap: 8px;
      background: rgba(255,255,255,0.12); backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,0.2); border-radius: 100px; padding: 6px 16px;
      color: #fff; font-size: 13px; font-weight: 500; margin-bottom: 24px; animation: fadeInDown 0.6s ease;
    }
    .hero-badge .dot { width: 8px; height: 8px; border-radius: 50%; background: hsl(180 100% 45%); animation: pulse-dot 2s infinite; }
    @keyframes pulse-dot { 0%,100%{opacity:1;transform:scale(1)} 50%{opacity:0.6;transform:scale(1.3)} }
    .service-hero h1 {
      font-family: 'Montserrat', sans-serif; font-size: clamp(2.2rem, 5vw, 3.8rem);
      font-weight: 900; color: #fff; line-height: 1.1; letter-spacing: -0.03em;
      margin-bottom: 20px; animation: fadeInUp 0.7s ease;
    }
    .service-hero h1 span { color: hsl(180 100% 55%); }
    .hero-desc { font-size: 1.15rem; color: rgba(255,255,255,0.85); max-width: 580px; line-height: 1.7; margin: 0 auto 36px auto; animation: fadeInUp 0.8s ease; }
    .hero-actions { display: flex; gap: 16px; flex-wrap: wrap; justify-content: center; animation: fadeInUp 0.9s ease; }
    .btn-hero-primary {
      display: inline-flex; align-items: center; gap: 10px;
      background: #fff; color: hsl(var(--brand-royal-blue));
      font-weight: 700; font-size: 1rem; padding: 14px 28px; border-radius: 14px;
      text-decoration: none; transition: all 0.3s ease; box-shadow: 0 8px 32px rgba(0,0,0,0.15);
    }
    .btn-hero-primary:hover { transform: translateY(-3px); box-shadow: 0 16px 40px rgba(0,0,0,0.2); }
    .btn-hero-outline {
      display: inline-flex; align-items: center; gap: 10px;
      border: 2px solid rgba(255,255,255,0.4); color: #fff;
      font-weight: 600; font-size: 1rem; padding: 12px 26px; border-radius: 14px;
      text-decoration: none; transition: all 0.3s ease; backdrop-filter: blur(8px);
    }
    .btn-hero-outline:hover { background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.7); }
    .hero-stats { display: flex; gap: 32px; margin-top: 48px; flex-wrap: wrap; justify-content: center; animation: fadeInUp 1s ease; }
    .hero-stat { text-align: center; }
    .hero-stat .num { font-family: 'Montserrat', sans-serif; font-size: 2rem; font-weight: 900; color: hsl(180 100% 55%); }
    .hero-stat .label { font-size: 0.8rem; color: rgba(255,255,255,0.7); margin-top: 2px; }
    @keyframes fadeInUp { from{opacity:0;transform:translateY(30px)} to{opacity:1;transform:translateY(0)} }
    @keyframes fadeInDown { from{opacity:0;transform:translateY(-20px)} to{opacity:1;transform:translateY(0)} }
    .site-nav {
      position: fixed; top: 0; left: 0; right: 0; z-index: 100;
      background: rgba(255,255,255,0.97); backdrop-filter: blur(20px);
      border-bottom: 1px solid hsl(var(--brand-royal-blue) / 0.1);
      box-shadow: 0 2px 20px rgba(0,0,0,0.06);
    }
    .nav-inner { max-width: 1440px; margin: 0 auto; padding: 0 2rem; display: flex; align-items: center; justify-content: space-between; height: 72px; }
    .nav-logo img { height: 50px; width: auto; }
    .nav-links { display: flex; gap: 32px; align-items: center; }
    .nav-links a { color: hsl(var(--brand-anthracite)); text-decoration: none; font-weight: 500; font-size: 0.95rem; transition: color 0.2s; }
    .nav-links a:hover, .nav-links a.active { color: hsl(var(--brand-royal-blue)); }
    .nav-cta { display: flex; align-items: center; gap: 12px; }
    .btn-nav-call {
      display: inline-flex; align-items: center; gap: 8px;
      background: linear-gradient(135deg, #22c55e, #059669);
      color: #fff; font-weight: 600; font-size: 0.9rem;
      padding: 10px 20px; border-radius: 12px; text-decoration: none; transition: all 0.3s;
    }
    .btn-nav-call:hover { transform: scale(1.05); }
    .btn-nav-devis {
      display: inline-flex; align-items: center; gap: 8px;
      background: var(--futur-gradient-primary);
      color: #fff; font-weight: 600; font-size: 0.9rem;
      padding: 10px 20px; border-radius: 12px; text-decoration: none; transition: all 0.3s;
    }
    .btn-nav-devis:hover { transform: translateY(-2px); box-shadow: var(--shadow-hover); }
    .page-content { max-width: 1440px; margin: 0 auto; padding: 80px 2rem; }
    @media (min-width: 1280px) {
      .container { max-width: 1440px !important; }
    }
    .features-section { margin-bottom: 80px; }
    .section-tag {
      display: flex; align-items: center; gap: 8px;
      width: fit-content; margin: 0 auto 16px auto;
      background: hsl(var(--brand-royal-blue) / 0.08); color: hsl(var(--brand-royal-blue));
      border: 1px solid hsl(var(--brand-royal-blue) / 0.2); border-radius: 100px; padding: 5px 14px;
      font-size: 12px; font-weight: 600; letter-spacing: 0.05em; text-transform: uppercase;
    }
    .section-title {
      font-family: 'Montserrat', sans-serif; font-size: clamp(1.8rem, 3vw, 2.6rem);
      font-weight: 800; color: hsl(var(--brand-anthracite)); letter-spacing: -0.02em; margin-bottom: 14px; line-height: 1.2;
      text-align: center;
    }
    .section-title span { background: var(--futur-gradient-accent); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
    .section-desc { font-size: 1.05rem; color: hsl(var(--brand-medium-gray)); max-width: 560px; line-height: 1.7; margin: 0 auto 48px auto; text-align: center; }
    .features-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 24px; }
    .feature-card {
      background: linear-gradient(145deg, #fff 0%, hsl(216 20% 98%) 100%);
      border: 1px solid hsl(var(--brand-royal-blue) / 0.1); border-radius: 20px; padding: 28px;
      transition: all 0.3s ease; position: relative; overflow: hidden;
    }
    .feature-card::before {
      content: ''; position: absolute; top: 0; left: 0; height: 3px; width: 100%;
      background: var(--futur-gradient-accent);
    }
    .feature-card:hover { transform: translateY(-8px); box-shadow: var(--shadow-hover); }
    .feature-icon {
      width: 48px; height: 48px; border-radius: 12px; background: var(--futur-gradient-accent);
      display: flex; align-items: center; justify-content: center; margin-bottom: 0; flex-shrink: 0;
      box-shadow: 0 8px 20px hsl(218 100% 45% / 0.25);
    }
    .feature-icon svg { width: 24px; height: 24px; color: #fff; fill: #fff; }
    .feature-card-header { display: flex; align-items: center; gap: 14px; margin-bottom: 12px; }
    .feature-card-header h3 { margin-bottom: 0; }
    .feature-card h3 { font-family: 'Montserrat', sans-serif; font-size: 1.1rem; font-weight: 700; color: hsl(var(--brand-anthracite)); margin-bottom: 10px; }
    .feature-card p { font-size: 0.9rem; color: hsl(var(--brand-medium-gray)); line-height: 1.65; }
    .process-section {
      background: linear-gradient(135deg, hsl(228 85% 8%) 0%, hsl(218 100% 38%) 100%);
      border-radius: 28px; padding: 64px 48px; margin-bottom: 80px; position: relative; overflow: hidden;
    }
    .process-section::before {
      content: ''; position: absolute; width: 400px; height: 400px; border-radius: 50%;
      background: radial-gradient(circle, hsl(180 100% 45% / 0.1) 0%, transparent 70%);
      top: -100px; right: -100px;
    }
    .process-section .section-title { color: #fff; }
    .process-section .section-title span { -webkit-text-fill-color: hsl(180 100% 65%); }
    .process-section .section-desc { color: rgba(255,255,255,0.75); }
    .steps-grid { display: grid; grid-template-columns: repeat(auto-fit, 220px); justify-content: center; gap: 20px; position: relative; z-index: 1; }
    .step-card {
      background: rgba(255,255,255,0.07); backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,0.12); border-radius: 18px; padding: 24px; text-align: center; transition: all 0.3s;
    }
    .step-card:hover { background: rgba(255,255,255,0.13); transform: translateY(-4px); }
    .step-number {
      width: 44px; height: 44px; border-radius: 50%; background: var(--futur-gradient-accent);
      color: #fff; font-family: 'Montserrat', sans-serif; font-weight: 800; font-size: 1rem;
      display: flex; align-items: center; justify-content: center; margin: 0 auto 14px;
    }
    .step-card h4 { font-family: 'Montserrat', sans-serif; font-size: 0.95rem; font-weight: 700; color: #fff; margin-bottom: 8px; }
    .step-card p { font-size: 0.82rem; color: rgba(255,255,255,0.7); line-height: 1.55; }
    .cta-section {
      background: linear-gradient(145deg, hsl(216 20% 97%) 0%, #fff 100%);
      border: 1px solid hsl(var(--brand-royal-blue) / 0.12); border-radius: 28px; padding: 60px 48px; text-align: center; margin-bottom: 40px;
    }
    .cta-section h2 { font-family: 'Montserrat', sans-serif; font-size: clamp(1.6rem, 3vw, 2.2rem); font-weight: 800; color: hsl(var(--brand-anthracite)); margin-bottom: 14px; }
    .cta-section p { color: hsl(var(--brand-medium-gray)); font-size: 1.05rem; margin-bottom: 32px; }
    .cta-buttons { display: flex; gap: 16px; justify-content: center; flex-wrap: wrap; }
    .btn-cta-main {
      display: inline-flex; align-items: center; gap: 10px;
      background: var(--futur-gradient-primary); color: #fff;
      font-weight: 700; font-size: 1rem; padding: 16px 32px; border-radius: 14px;
      text-decoration: none; transition: all 0.3s; box-shadow: 0 8px 32px hsl(218 100% 45% / 0.3);
    }
    .btn-cta-main:hover { transform: translateY(-3px); box-shadow: var(--shadow-hover); }
    .btn-cta-call {
      display: inline-flex; align-items: center; gap: 10px;
      background: linear-gradient(135deg, #22c55e, #059669);
      color: #fff; font-weight: 700; font-size: 1rem; padding: 16px 32px;
      border-radius: 14px; text-decoration: none; transition: all 0.3s;
    }
    .btn-cta-call:hover { transform: translateY(-3px); }
    .breadcrumb { display: flex; gap: 8px; align-items: center; justify-content: center; margin-bottom: 20px; animation: fadeInUp 0.6s ease; }
    .breadcrumb a { color: rgba(255,255,255,0.7); font-size: 0.88rem; text-decoration: none; transition: color 0.2s; }
    .breadcrumb a:hover { color: #fff; }
    .breadcrumb span { color: rgba(255,255,255,0.4); font-size: 0.88rem; }
    .breadcrumb .current { color: rgba(255,255,255,0.9); font-size: 0.88rem; }
    .included-section { margin-bottom: 80px; }
    .included-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
    @media(max-width:600px){ .included-grid { grid-template-columns: 1fr; } }
    .included-item {
      display: flex; align-items: flex-start; gap: 14px;
      background: hsl(216 20% 97%); border-radius: 14px; padding: 18px 20px;
      border: 1px solid hsl(var(--brand-royal-blue) / 0.08); transition: all 0.25s;
    }
    .included-item:hover { background: #fff; box-shadow: 0 4px 20px rgba(0,0,0,0.06); }
    .check-icon { width: 22px; height: 22px; flex-shrink: 0; margin-top: 1px; stroke: hsl(var(--brand-tech-cyan)); }
    .included-item span { font-size: 0.92rem; color: hsl(var(--brand-anthracite)); font-weight: 500; line-height: 1.5; }
    .site-footer { background: hsl(var(--brand-deep-blue)); color: #fff; padding: 48px 2rem 32px; }
    .footer-inner { max-width: 1440px; margin: 0 auto; }
    .footer-top { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 48px; margin-bottom: 40px; }
    @media(max-width:768px){ .footer-top { grid-template-columns: 1fr; gap: 32px; } }
    .footer-brand img { height: 44px; margin-bottom: 16px; }
    .footer-brand p { color: rgba(255,255,255,0.7); font-size: 0.88rem; line-height: 1.65; }
    .footer-col h4 { font-family: 'Montserrat', sans-serif; font-size: 0.95rem; font-weight: 700; color: hsl(195 100% 55%); margin-bottom: 16px; }
    .footer-col ul { list-style: none; display: flex; flex-direction: column; gap: 8px; }
    .footer-col ul li a { color: rgba(255,255,255,0.7); text-decoration: none; font-size: 0.87rem; transition: color 0.2s; }
    .footer-col ul li a:hover { color: #fff; }
    .footer-bottom { border-top: 1px solid rgba(255,255,255,0.1); padding-top: 24px; display: flex; justify-content: space-between; flex-wrap: wrap; gap: 12px; }
    .footer-bottom p { font-size: 0.82rem; color: rgba(255,255,255,0.5); }
    @media(max-width:768px){
      .nav-links, .nav-cta { display: none; }
      .features-grid { grid-template-columns: 1fr; }
      .steps-grid { grid-template-columns: 1fr; }
      .process-section { padding: 40px 24px; }
      .cta-section { padding: 40px 24px; }
      .page-content { padding: 48px 1.25rem; }
    }
  </style>
</head>
<body>
"@ + @"

<header class="fixed top-0 left-0 right-0 z-50 bg-white/98 backdrop-blur-xl border-b border-brand-royal-blue/10 shadow-futur">
  <div class="container mx-auto px-4">
    <div class="flex items-center justify-between h-20">
      <div class="flex items-center space-x-6">
        <a class="flex-shrink-0 transition-transform hover:scale-105 duration-300" href="../index.html"><img src="../assets/futur-toiture-logo-D2vatSlf.png" alt="Futur Toiture - Couvreur professionnel" class="h-14 w-auto drop-shadow-lg"></a>
        <div class="hidden lg:flex items-center space-x-3">
          <div class="flex items-center space-x-1 bg-green-50 px-3 py-1.5 rounded-full border border-green-200"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-shield w-4 h-4 text-green-600"><path d="M12 1 3 5v7c0 6 4 11.5 9 12.5 5-1 9-6.5 9-12.5V5z"/></svg><span class="text-xs font-medium text-green-800">Garantie décennale</span></div>
          <div class="flex items-center space-x-1 bg-blue-50 px-3 py-1.5 rounded-full border border-blue-200"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-award w-4 h-4 text-blue-600"><path d="m15.5 12.9 1.5 8.5a.5.5 0 0 1-.8.5l-3.6-2.7a1 1 0 0 0-1.2 0l-3.6 2.7a.5.5 0 0 1-.8-.5l1.5-8.5"/><circle cx="12" cy="8" r="6"/></svg><span class="text-xs font-medium text-blue-800">Google certifié</span></div>
        </div>
      </div>
      <nav class="hidden md:flex items-center space-x-10"><a class="relative text-base font-semibold transition-all duration-300 hover:scale-105 text-brand-anthracite hover:text-brand-royal-blue" href="../index.html">Accueil</a><a class="relative text-base font-semibold transition-all duration-300 hover:scale-105 text-brand-anthracite hover:text-brand-royal-blue" href="../renovation-toiture.html">Rénovation</a><a class="relative text-base font-semibold transition-all duration-300 hover:scale-105 text-brand-anthracite hover:text-brand-royal-blue" href="../urgence-fuite-toiture.html">Urgence</a><a class="relative text-base font-semibold transition-all duration-300 hover:scale-105 text-brand-royal-blue after:absolute after:bottom-0 after:left-0 after:w-full after:h-0.5 after:bg-gradient-to-r after:from-brand-royal-blue after:to-brand-tech-cyan after:rounded-full" href="../autres-services.html">Autres services</a></nav>
      <div class="hidden md:flex items-center space-x-3">
        <div class="flex flex-col items-center"><a href="tel:+33780971996" class="btn-phone shadow-lg hover:shadow-glow" aria-label="Appeler Futur Toiture"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-phone w-4 h-4 mr-2"><path d="M22 16.9v3c0 1.1-.9 2-2 2a19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.3 4.1 2 2 0 0 1 4.1 2h3c1.1 0 2 .9 2 2 0 .2 0 .5.1.7a12.8 12.8 0 0 0 .7 2.8 2 2 0 0 1-.5 2.1L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5 12.8 12.8 0 0 0 2.8.7c.2 0 .5.1.7.1 1.1 0 2 .9 2 2z"/></svg>07 80 97 19 96</a><span class="text-xs text-brand-medium-gray mt-1 font-medium">Appel gratuit</span></div><a href="../index.html#diagnostic" class="btn-primary shadow-lg"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-file-text w-4 h-4 mr-2"><path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8zm-1 2 5 5h-5zM8 13h8v2H8zm0 4h8v2H8zm0-8h3v2H8z"/></svg>Devis gratuit</a>
      </div>
      <div class="md:hidden flex items-center space-x-3"><a href="tel:+33780971996" class="btn-phone text-sm px-4 py-2.5 shadow-lg hover:shadow-glow" aria-label="Appeler Futur Toiture"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-phone w-4 h-4 mr-2"><path d="M22 16.9v3c0 1.1-.9 2-2 2a19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.3 4.1 2 2 0 0 1 4.1 2h3c1.1 0 2 .9 2 2 0 .2 0 .5.1.7a12.8 12.8 0 0 0 .7 2.8 2 2 0 0 1-.5 2.1L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5 12.8 12.8 0 0 0 2.8.7c.2 0 .5.1.7.1 1.1 0 2 .9 2 2z"/></svg>Appeler</a><button type="button" class="inline-flex items-center justify-center p-3 rounded-2xl text-brand-anthracite hover:text-brand-royal-blue hover:bg-brand-light-gray/50 focus:outline-none focus:ring-2 focus:ring-brand-tech-cyan transition-all duration-300 hover:scale-105"><span class="sr-only">Ouvrir le menu principal</span>
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-menu block h-6 w-6" aria-hidden="true"><rect x="3" y="5" width="18" height="2" rx="1"/><rect x="3" y="11" width="18" height="2" rx="1"/><rect x="3" y="17" width="18" height="2" rx="1"/></svg>
        </button>
      </div>
    </div>
  </div>
</header>

<section class="service-hero">
  <div class="hero-content">
    <div class="breadcrumb"><a href="../index.html">Accueil</a><span>›</span><a href="../autres-services.html">Services</a><span>›</span><span class="current">$($service.title)</span></div>
    <div class="hero-badge"><span class="dot"></span>Service professionnel certifié</div>
    <h1>$($service.titleHtml)</h1>
    <p class="hero-desc">$($service.desc)</p>
    <div class="hero-actions">
      <a href="tel:+33780971996" class="btn-hero-primary"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M22 16.9v3c0 1.1-.9 2-2 2a19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.3 4.1 2 2 0 0 1 4.1 2h3c1.1 0 2 .9 2 2 0 .2 0 .5.1.7a12.8 12.8 0 0 0 .7 2.8 2 2 0 0 1-.5 2.1L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5 12.8 12.8 0 0 0 2.8.7c.2 0 .5.1.7.1 1.1 0 2 .9 2 2z"/></svg>Appeler maintenant</a>
      <a href="../index.html#diagnostic" class="btn-hero-outline"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8zm-1 2 5 5h-5z"/></svg>Devis gratuit</a>
    </div>
    <div class="hero-stats">
      <div class="hero-stat"><div class="num">24h</div><div class="label">Réponse garantie</div></div>
      <div class="hero-stat"><div class="num">70km</div><div class="label">Zone Alès - Gard</div></div>
      <div class="hero-stat"><div class="num">10+</div><div class="label">Années d'expérience</div></div>
      <div class="hero-stat"><div class="num">100%</div><div class="label">Devis gratuit</div></div>
    </div>
  </div>
</section>

<div class="page-content">
  <section class="features-section">
    <div class="section-tag">Notre expertise</div>
    <h2 class="section-title">Un service <span>professionnel et complet</span></h2>
    <p class="section-desc">Notre équipe de couvreurs certifiés met tout son savoir-faire à votre service pour des résultats durables et de qualité.</p>
    <div class="features-grid">
$featuresHtml    </div>
  </section>
  <section class="included-section">
    <div class="section-tag">Inclus dans chaque prestation</div>
    <h2 class="section-title">Ce qui est <span>inclus</span></h2>
    <p class="section-desc">Chaque prestation comprend un ensemble de services pour assurer votre entière satisfaction.</p>
    <div class="included-grid">
$includedHtml    </div>
  </section>
  <section class="process-section">
    <div class="section-tag" style="background:rgba(255,255,255,0.12);color:#fff;border-color:rgba(255,255,255,0.2);">Notre processus</div>
    <h2 class="section-title">Comment nous <span>travaillons</span></h2>
    <p class="section-desc">Un processus simple, transparent et efficace de la prise de contact jusqu'à la livraison de votre chantier.</p>
    <div class="steps-grid">
      <div class="step-card"><div class="step-number">1</div><h4>Prise de contact</h4><p>Appelez-nous ou demandez un devis en ligne. Nous vous rappelons sous 2h.</p></div>
      <div class="step-card"><div class="step-number">2</div><h4>Devis gratuit</h4><p>Un expert se déplace pour évaluer votre projet et vous remettre un devis précis.</p></div>
      <div class="step-card"><div class="step-number">3</div><h4>Réalisation</h4><p>Nos équipes interviennent avec soin, dans les délais convenus et selon les règles de l'art.</p></div>
      <div class="step-card"><div class="step-number">4</div><h4>Réception</h4><p>Vérification finale avec vous pour votre entière satisfaction. Garantie décennale remise.</p></div>
    </div>
  </section>
  <section class="cta-section">
    <h2>Prêt à démarrer votre projet ?</h2>
    <p>Contactez-nous dès aujourd'hui pour un devis gratuit sous 24h. 7j/7 dans tout le Gard (30) et alentours.</p>
    <div class="cta-buttons">
      <a href="../index.html#diagnostic" class="btn-cta-main"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8zm-1 2 5 5h-5z"/></svg>Devis gratuit</a>
      <a href="tel:+33780971996" class="btn-cta-call"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M22 16.9v3c0 1.1-.9 2-2 2a19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.3 4.1 2 2 0 0 1 4.1 2h3c1.1 0 2 .9 2 2 0 .2 0 .5.1.7a12.8 12.8 0 0 0 .7 2.8 2 2 0 0 1-.5 2.1L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5 12.8 12.8 0 0 0 2.8.7c.2 0 .5.1.7.1 1.1 0 2 .9 2 2z"/></svg>07 80 97 19 96</a>
    </div>
  </section>
</div>

<footer class="site-footer bg-slate-900 text-white py-12 border-t border-slate-800">
  <div class="container mx-auto px-4">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
      <div class="space-y-6"><img src="../assets/futur-toiture-logo-D2vatSlf.png" alt="Futur Toiture" class="h-12 w-auto"><p class="text-blue-100/70 text-sm leading-relaxed">Couvreur professionnel à Alès. Rénovation, réparation d'urgence, démoussage. Devis gratuit sous 24h. Intervention rapide et garantie décennale.</p></div>
      <div><h4 class="text-lg font-semibold mb-4 text-brand-light-blue">Contact</h4><div class="space-y-3"><a href="tel:+33780971996" class="flex items-center text-blue-100 hover:text-white transition-colors"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-phone w-4 h-4 mr-3 text-brand-light-blue"><path d="M22 16.9v3c0 1.1-.9 2-2 2a19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.3 4.1 2 2 0 0 1 4.1 2h3c1.1 0 2 .9 2 2 0 .2 0 .5.1.7a12.8 12.8 0 0 0 .7 2.8 2 2 0 0 1-.5 2.1L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5 12.8 12.8 0 0 0 2.8.7c.2 0 .5.1.7.1 1.1 0 2 .9 2 2z"/></svg><span>07 80 97 19 96</span></a><a href="mailto:futurtoiture1@gmail.com" class="flex items-center text-blue-100 hover:text-white transition-colors"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-mail w-4 h-4 mr-3 text-brand-light-blue"><rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-9 5.7c-.6.4-1.4.4-2 0L2 7"/></svg><span>futurtoiture1@gmail.com</span></a><a href="https://www.google.com/maps/place/36B+Chem.+des+Caves,+30340+Al%C3%A8s/" target="_blank" rel="noopener noreferrer" class="flex items-center text-blue-100 hover:text-white transition-colors"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-map-pin w-4 h-4 mr-3 text-brand-light-blue"><path d="M20 10c0 5-5.5 10.2-7.4 11.8a1 1 0 0 1-1.2 0C9.5 20.2 4 15 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg><span>36B Chem. des Caves, 30340 Alès</span></a></div></div>
      <div><h4 class="text-lg font-semibold mb-4 text-brand-light-blue">Nos Services</h4><ul class="space-y-2"><li><a class="text-blue-100 hover:text-white transition-colors text-sm" href="../renovation-toiture.html">Rénovation de toiture</a></li><li><a class="text-blue-100 hover:text-white transition-colors text-sm" href="../urgence-fuite-toiture.html">Réparation d'urgence</a></li><li><a class="text-blue-100 hover:text-white transition-colors text-sm" href="inspection-toitures.html">Inspection de toitures</a></li><li><a class="text-blue-100 hover:text-white transition-colors text-sm" href="installation-gouttieres.html">Installation gouttières</a></li><li><a class="text-blue-100 hover:text-white transition-colors text-sm" href="installation-velux.html">Installation Velux</a></li><li><a class="text-blue-100 hover:text-white transition-colors text-sm" href="zinguerie.html">Travaux de Zinguerie</a></li><li><a class="text-blue-100 hover:text-white transition-colors text-sm" href="isolation-toiture.html">Isolation de toiture</a></li></ul></div>
      <div><h4 class="text-lg font-semibold mb-4 text-brand-light-blue">Zone d'intervention</h4><div class="text-blue-100 text-sm space-y-1"><p class="font-medium text-white">Alès et alentours :</p><p>Nîmes, Montpellier</p><p>Uzès, Bagnols-sur-Cèze</p><p>Villeneuve-lès-Avignon</p><p>Anduze, Saint-Hippolyte-du-Fort</p><p class="text-xs italic mt-2">Intervention dans un rayon de 70km</p></div></div>
    </div>
    <div class="border-t border-blue-800 mt-8 pt-8"><div class="flex flex-col lg:flex-row justify-between items-center space-y-4 lg:space-y-0"><div class="flex flex-wrap items-center justify-center lg:justify-start space-x-6 text-sm"><a class="text-blue-100 hover:text-white transition-colors" href="../mentions-legales.html">Mentions légales</a><a class="text-blue-100 hover:text-white transition-colors" href="../politique-confidentialite.html">Politique de confidentialité</a><a href="https://www.google.com/maps/place/Couvreur+Winaud+-+Couvreur+Al%C3%A8s" target="_blank" rel="noopener noreferrer" class="flex items-center text-blue-100 hover:text-white transition-colors"><span>Avis Google</span><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-external-link w-3 h-3 ml-1"><path d="M15 3h6v6"/><path d="M10 14 21 3"/><path d="M18 13v6c0 1.1-.9 2-2 2H5c-1.1 0-2-.9-2-2V8c0-1.1.9-2 2-2h6"/></svg></a></div><div class="text-blue-200 text-sm text-center lg:text-right flex flex-col lg:flex-row lg:items-center space-y-2 lg:space-y-0 lg:space-x-4"><img src="../assets/futur-toiture-logo-D2vatSlf.png" alt="Futur Toiture" class="h-8 w-auto object-contain mx-auto lg:mx-0"><div><p>© 2025 Futur Toiture - Couvreur professionnel</p><p class="text-xs">SIRET: 53205005100020 | RC Pro | Garantie décennale</p></div></div></div></div>
  </div>
</footer>

<div class="fixed bottom-0 left-0 right-0 z-40 md:hidden bg-white/98 backdrop-blur-xl border-t border-brand-royal-blue/20 shadow-futur">
  <div class="space-y-2 p-2">
    <div class="grid grid-cols-2 h-16 gap-2">
      <a href="tel:+33780971996" class="flex flex-col items-center justify-center bg-gradient-to-r from-green-500 to-emerald-600 text-white font-bold text-sm rounded-2xl hover:shadow-glow active:scale-95 transition-all duration-300 shadow-lg"><div class="flex items-center"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-phone w-4 h-4 mr-1.5"><path d="M22 16.9v3c0 1.1-.9 2-2 2a19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.3 4.1 2 2 0 0 1 4.1 2h3c1.1 0 2 .9 2 2 0 .2 0 .5.1.7a12.8 12.8 0 0 0 .7 2.8 2 2 0 0 1-.5 2.1L8.1 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.5 12.8 12.8 0 0 0 2.8.7c.2 0 .5.1.7.1 1.1 0 2 .9 2 2z"/></svg><span class="text-sm">Appeler</span></div><span class="text-xs opacity-80">Appel gratuit</span></a>
      <a href="../index.html#diagnostic" class="flex items-center justify-center rounded-2xl font-bold text-sm hover:shadow-hover active:scale-95 transition-all duration-300 text-white relative overflow-hidden shadow-lg" style="background: var(--futur-gradient-primary);"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-file-text w-4 h-4 mr-1.5"><path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8zm-1 2 5 5h-5z"/></svg><span class="text-sm">Devis gratuit</span><div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent translate-x-[-100%] skew-x-12 transition-transform duration-700 hover:translate-x-[100%]"></div></a>
    </div>
    <div class="flex justify-center space-x-2 px-2 pb-1">
      <div class="flex items-center space-x-1 bg-green-50 px-2 py-1 rounded-full border border-green-200"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-shield w-3 h-3 text-green-600"><path d="M12 1 3 5v7c0 6 4 11.5 9 12.5 5-1 9-6.5 9-12.5V5z"/></svg><span class="text-xs font-medium text-green-800">Garantie 10ans</span></div>
      <div class="flex items-center space-x-1 bg-blue-50 px-2 py-1 rounded-full border border-blue-200"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="lucide lucide-award w-3 h-3 text-blue-600"><path d="m15.5 12.9 1.5 8.5a.5.5 0 0 1-.8.5l-3.6-2.7a1 1 0 0 0-1.2 0l-3.6 2.7a.5.5 0 0 1-.8-.5l1.5-8.5"/><circle cx="12" cy="8" r="6"/></svg><span class="text-xs font-medium text-blue-800">40+ avis Google</span></div>
    </div>
  </div>
</div>

<script src="../embed/v1/index.html" async=""></script>
<script src="../assets/js/interactions.js" defer></script>
</body>
</html>
"@
}

# Generate all pages with UTF-8 BOM
$utf8 = New-Object System.Text.UTF8Encoding $true
foreach ($service in $services) {
    $html = Generate-Page -service $service
    $filePath = Join-Path $rootPath "$($service.slug).html"
    [System.IO.File]::WriteAllText($filePath, $html, $utf8)
    Write-Host "Created: $($service.slug).html"
}
Write-Host "`nAll 12 service pages generated with filled flat icons!"
