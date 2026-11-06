#!/bin/sh
# رفع كامل بأمر واحد: تثبيت + تسجيل دخول (لو لازم) + إنشاء الجداول + نشر + فحص
set -e
cd "$(dirname "$0")"
npm install
npx wrangler whoami >/dev/null 2>&1 || npx wrangler login
npx wrangler d1 execute adwmx --remote --file=./schema.sql || echo "(تخطّي: الجداول هتتنشأ تلقائياً من الـ Worker)"
npx wrangler deploy
node check.mjs
