#!/bin/bash

echo "🚀 جاري إنشاء ملف APK (Release)..."
flutter build apk --release

# مسار الملف الناتج
SOURCE_APK="build/app/outputs/flutter-apk/app-release.apk"

# تحديد سطح المكتب (لمستخدمي ويندوز)
DESKTOP_PATH="/c/Users/$USER/Desktop"

if [ -f "$SOURCE_APK" ]; then
    echo "✅ تم إنشاء الملف بنجاح. جاري نقله إلى سطح المكتب..."
    cp "$SOURCE_APK" "$DESKTOP_PATH/Chemistry_Initiative.apk"
    echo "🎉 الملف متاح الآن على سطح المكتب باسم: Chemistry_Initiative.apk"
else
    echo "❌ فشل إنشاء الملف. يرجى التأكد من عدم وجود أخطاء في الكود."
fi
