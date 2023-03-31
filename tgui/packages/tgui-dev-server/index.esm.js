import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const esmRequire = require('esm')(module, {
  cache: false,
});

esmRequire('./index.js');
