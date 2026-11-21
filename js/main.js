// Small progressive enhancements: scroll reveal + active nav link.
// The site works fully without JavaScript.
(function () {
  const reveals = document.querySelectorAll(".reveal");
  if ("IntersectionObserver" in window) {
    const io = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-visible");
            io.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.12, rootMargin: "0px 0px -40px 0px" }
    );
    reveals.forEach((el) => io.observe(el));
  } else {
    reveals.forEach((el) => el.classList.add("is-visible"));
  }

  // Highlight the nav link for the section currently in view.
  const links = [...document.querySelectorAll('.nav__link[href^="#"]')];
  const sections = links.map((l) => document.querySelector(l.getAttribute("href"))).filter(Boolean);
  const setActive = () => {
    if (!sections.length) return; // e.g. case study pages, whose nav links point back to index.html
    const y = window.scrollY + window.innerHeight * 0.35;
    let current = sections[0];
    sections.forEach((s) => { if (s.offsetTop <= y) current = s; });
    links.forEach((l) => l.classList.toggle("is-active", l.getAttribute("href") === "#" + current.id));
  };
  window.addEventListener("scroll", setActive, { passive: true });
  setActive();

  // Hero side panels: flower pattern paints in from the cursor, with a pencil cursor.
  const cursor = document.querySelector(".pencil-cursor");
  if (cursor) document.querySelectorAll(".hero__side").forEach((side) => {
    const fill = side.querySelector(".hero__fill");
    const track = (e) => {
      const r = side.getBoundingClientRect();
      fill.style.setProperty("--x", e.clientX - r.left + "px");
      fill.style.setProperty("--y", e.clientY - r.top + "px");
      cursor.style.setProperty("--cx", e.clientX + "px");
      cursor.style.setProperty("--cy", e.clientY + "px");
    };
    side.addEventListener("pointerenter", (e) => {
      track(e);
      side.classList.add("is-on");
      cursor.classList.add("is-on");
    });
    side.addEventListener("pointermove", track);
    side.addEventListener("pointerleave", (e) => {
      track(e); // collapse back toward the exit point
      side.classList.remove("is-on");
      cursor.classList.remove("is-on");
    });
  });
})();
