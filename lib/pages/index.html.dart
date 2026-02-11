<!DOCTYPE html>
<html lang="ar" dir="rtl">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="اكتشف سر رائحة القهوة الصباحية الجميلة وكيف تؤثر على دماغك ويقظتك">
    <title>ما الذي يجعل رائحة قهوتي الصباحية جميلة جداً؟</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;600;700&display=swap" rel="stylesheet">

    <!-- External CSS -->
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <div class="container">
        <div class="card">
            <!-- Back Button -->
            <button class="back-button" onclick="window.history.back()">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M15 18L9 12L15 6" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" />
                </svg>
            </button>

            <!-- Image Section -->
            <div class="image-container">
                <img src="https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&h=400&fit=crop"
                    alt="فنجان قهوة صباحي" class="main-image" loading="lazy">
            </div>

            <!-- Daily Magic Badge -->
            <div class="image-caption">
                <span class="magic-badge">سحر يومي</span>
            </div>

            <!-- Main Title -->
            <h1 class="main-title">ما الذي يجعل رائحة قهوتي الصباحية جميلة جداً؟</h1>

            <!-- Info List -->
            <div class="info-list">
                <div class="info-item" data-step="1">
                    <div class="number">١</div>
                    <p>حبوب القهوة مثل صناديق الكنز الصغيرة. تحتوي على أكثر من 1000 جزيء رائحة مختلف بداخلها.</p>
                </div>

                <div class="info-item hidden" data-step="2">
                    <div class="number">٢</div>
                    <p>عندما يلامس الماء الساخن الحبوب، يكون الأمر مثل فتح كل تلك الصناديق دفعة واحدة. تطفو الجزيئات في
                        الهواء.</p>
                </div>

                <div class="info-item hidden" data-step="3">
                    <div class="number">٣</div>
                    <p>أنفك يلتقط هذه الجزيئات الطافية. كل واحدة تخبر دماغك قصة مختلفة: كراميل، شوكولاتة، زهور، مكسرات.
                    </p>
                </div>

                <div class="info-item hidden" data-step="4">
                    <div class="number">٤</div>
                    <p>الحرارة هي المفتاح. بدونها، تبقى الحبوب مقفلة. لهذا السبب الحبوب الباردة ليس لها رائحة قوية!</p>
                </div>
            </div>

            <!-- Knowledge Box -->
            <div class="knowledge-box">
                <div class="knowledge-header">
                    <span class="knowledge-icon">💡</span>
                    <span class="knowledge-title">هل تعلم؟</span>
                </div>
                <p class="knowledge-text">يمكن لرائحة القهوة أن تجعلك تشعر بمزيد من اليقظة حتى قبل أن تشربها! يتعرف
                    دماغك على الرائحة ويبدأ في تحضير جسمك للكافيين!</p>
            </div>

            <!-- CTA Button -->
            <button class="cta-button" id="revealButton">
                <span>أخبرني المزيد</span>
            </button>
        </div>
    </div>

    <!-- External JavaScript -->
    <script src="script.js"></script>
</body>

</html>