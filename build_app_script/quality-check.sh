#!/usr/bin/env bash

# 0. Switch workin directory
cd shop-angular-cloudfront

# 1. Perform tests
npm run lint
npm run test
npm run e2e