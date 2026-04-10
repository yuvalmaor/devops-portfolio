# DevOps Space Portfolio (Astro)

A futuristic, space-themed DevOps portfolio built with [Astro](https://astro.build/) and optimized for static hosting on Amazon S3.

## Features

- Space-themed visual interface (stars, nebula, glassmorphism panels)
- Fake animated DevOps CLI terminal
- Responsive sections for skills, mission control, and project timeline
- Static site output suitable for S3 website hosting

## Quick Start

```bash
npm install
npm run dev
```

## Build for S3

```bash
npm run build
```

Generated static files are in `dist/`.

## Deploy to S3

```bash
aws s3 sync dist/ s3://YOUR_BUCKET_NAME --delete
```

If you're using S3 static website hosting, configure the bucket website endpoint and set `index.html` as both index and error document.
