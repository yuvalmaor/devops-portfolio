import { defineConfig } from 'astro/config';

export default defineConfig({
  output: 'static',
  site: 'https://example-bucket.s3-website-us-east-1.amazonaws.com'
});
