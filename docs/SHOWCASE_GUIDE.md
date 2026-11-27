# Robuntu showcase guide

A curated subset of the original `Imagens PAP` captures is now included in `assets/images/`. The README uses them to tell the build story without presenting command snippets as proof of a successful runtime test.

## Included captures

- `cubic-base-image.png` — Cubic metadata for the Ubuntu 20.04.6 Desktop amd64 base image
- `cubic-filesystem-settings.png` — filesystem compression choice before image generation
- `docker-setup-script.png` — Docker section of the post-install script
- `mrs-uav-catkin-build-script.png` — catkin configuration and build section

These are process records. Add actual desktop screenshots or a ROS/MRS UAV runtime demo after a clean test run, and caption each image with what was tested.

## Add future screenshots

Save authentic screenshots in `assets/images/` and embed them from the root README with relative links:

```markdown
![Robuntu desktop with its robotics tools ready](assets/images/robuntu-desktop.png)
```

A useful next set would show:

1. The installed desktop with personal accounts and notifications hidden
2. A ROS tool or visualization running successfully
3. An MRS UAV simulation or robotics workflow
4. Arduino IDE, if it is a central use case

Crop out usernames, network addresses, tokens, and unrelated windows. Do not use generated images as evidence of a working screen or feature. A short screen recording can supplement the README, but keep written steps and screenshots for readers who cannot play video.