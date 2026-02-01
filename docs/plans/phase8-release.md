# Phase 8: Release Pipeline — Detailed Plan

> **Status**: ⏳ Pending  
> **Goal**: Production-ready deployment.

---

## Overview

This phase prepares the game for public release across all target platforms.

---

## 8.1 CI/CD Pipeline

### GitHub Actions
- [ ] Build workflow for each platform
- [ ] Automated testing on PR
- [ ] Version tagging and changelog
- [ ] Automated deployment triggers

### Workflow Structure
```yaml
# .github/workflows/build.yml
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    # Run tests
  build-web:
    # Build web version
  build-android:
    # Build APK
  build-ios:
    # Build IPA (if on macOS runner)
  deploy:
    # Deploy to hosting
```

---

## 8.2 Web Deployment

### Build
- [ ] Optimize build flags (`--release`)
- [ ] Enable tree shaking
- [ ] Minify assets
- [ ] Configure PWA manifest

### Hosting
- [ ] Deploy to GitHub Pages or Vercel
- [ ] Configure custom domain (optional)
- [ ] Set up HTTPS
- [ ] Test on major browsers

---

## 8.3 Android Build

### Configuration
- [ ] Set package name
- [ ] Configure signing keys
- [ ] Set up release keystore
- [ ] Configure ProGuard rules

### Release
- [ ] Build signed APK
- [ ] Build App Bundle (AAB)
- [ ] Test on multiple devices
- [ ] Prepare Play Store listing (optional)

---

## 8.4 iOS Build

### Configuration
- [ ] Set bundle identifier
- [ ] Configure signing certificates
- [ ] Set up provisioning profiles
- [ ] Configure App Store Connect

### Release
- [ ] Build IPA
- [ ] Test on physical devices
- [ ] Submit for TestFlight (optional)
- [ ] Prepare App Store listing (optional)

---

## 8.5 Performance Optimization

### Profiling
- [ ] Run Flutter DevTools profiler
- [ ] Identify frame drops
- [ ] Check memory usage
- [ ] Monitor asset loading

### Optimizations
- [ ] Sprite atlas consolidation
- [ ] Lazy loading for locations
- [ ] Object pooling for particles
- [ ] Reduce draw calls if needed

---

## 8.6 QA Checklist

### Functionality
- [ ] Complete playthrough test
- [ ] All features working
- [ ] Save/load reliability
- [ ] Edge case handling

### Platforms
- [ ] Web (Chrome, Firefox, Safari)
- [ ] Android (various screen sizes)
- [ ] iOS (various screen sizes)

### Performance
- [ ] 60 FPS on target devices
- [ ] Reasonable loading times
- [ ] No memory leaks

---

## Done Criteria

Phase 8 is complete when:
- [ ] CI/CD pipeline running on GitHub Actions
- [ ] Web version deployed and accessible
- [ ] Android APK builds successfully
- [ ] iOS IPA builds successfully
- [ ] Performance meets targets
- [ ] QA checklist passed

---

## Next Phase

After release, proceed to [Phase 9: Content & Polish](phase9-content-polish.md) to expand the game.
