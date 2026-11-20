# Prajakta Vispute — Portfolio (HTML/CSS)

A plain HTML + CSS + a little vanilla JS rebuild of the Framer site "Prajakta Portfolio" (home page at `/`). It needs no build step and no framework.

## Get started in VS Code

1. Open this folder in VS Code (**File → Open Folder…**).
2. Download the images once. They still live on Framer's CDN, and this copies them into `assets/` so the site stops depending on Framer:
   - **Windows:** run `powershell -ExecutionPolicy Bypass -File .\download-assets.ps1` in the VS Code terminal
   - **macOS / Linux:** run `bash download-assets.sh`
3. Install the **Live Server** extension (by Ritwick Dey), right-click `index.html` and choose **Open with Live Server**.

## Structure

```
index.html            all page content and sections
css/styles.css        design tokens (colours, fonts) at the top, then each section
js/main.js            scroll-reveal animation and active-nav highlighting
assets/               images (filled by the download script)
assets-manifest.txt   list of image URLs the script downloads
```

## Things to fill in (these were placeholders in Framer too)

- **Project cards** (`#work`): the titles, descriptions and "Project type" lines are still placeholder copy, the thumbnails are empty, and the links point to `#`. To add a cover image, set `style="background-image:url(assets/your-image.png)"` on `.project__thumb`.
- **Footer LinkedIn / Behance:** the Framer site had no URLs for these, so they point to `#`.
- **Toolkit icons:** check the `alt` text in the Toolkit list. The fifth icon is labelled generically.

## Notes on the migration

- Fonts load from Google Fonts: Instrument Serif, Instrument Sans, Geist, Carattere, Newsreader, Inter and Outfit, the same families the Framer site used.
- The Framer page was a fixed 1486px desktop layout imported from Figma. This version is responsive: the hero lockup and gallery tiles scale with the viewport, and cards, the gallery, the About section and the footer stack on small screens.
- The decorative hover panels in the hero side margins ("Flower slide" / "Black" components) were not carried over.
- Older Framer pages (`/old-home`, `/p` and the empty `/page`) were not migrated. Only the live home page was.
