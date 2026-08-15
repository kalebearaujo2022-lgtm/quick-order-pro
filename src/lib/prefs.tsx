import { createContext, useContext, useEffect, useMemo, useState } from "react";

type Prefs = {
  theme: "light" | "dark";
  fontScale: number;
  highContrast: boolean;
  reduceMotion: boolean;
  highlightLinks: boolean;
};

const DEFAULTS: Prefs = {
  theme: "dark",
  fontScale: 100,
  highContrast: false,
  reduceMotion: false,
  highlightLinks: false,
};

type Ctx = Prefs & {
  toggleTheme: () => void;
  update: (patch: Partial<Prefs>) => void;
  reset: () => void;
};

const PrefsCtx = createContext<Ctx>({ ...DEFAULTS, toggleTheme: () => {}, update: () => {}, reset: () => {} });

export function PrefsProvider({ children }: { children: React.ReactNode }) {
  const [prefs, setPrefs] = useState<Prefs>(DEFAULTS);

  useEffect(() => {
    try {
      const raw = localStorage.getItem("av-prefs");
      if (raw) setPrefs({ ...DEFAULTS, ...JSON.parse(raw) });
    } catch {
      /* ignore */
    }
  }, []);

  useEffect(() => {
    const root = document.documentElement;
    root.classList.toggle("dark", prefs.theme === "dark");
    root.classList.toggle("hc", prefs.highContrast);
    root.classList.toggle("reduce-motion", prefs.reduceMotion);
    root.classList.toggle("highlight-links", prefs.highlightLinks);
    root.style.setProperty("--app-font-scale", `${prefs.fontScale}%`);
  }, [prefs]);

  const value = useMemo<Ctx>(
    () => ({
      ...prefs,
      toggleTheme: () =>
        setPrefs((p) => {
          const next = { ...p, theme: p.theme === "dark" ? ("light" as const) : ("dark" as const) };
          localStorage.setItem("av-prefs", JSON.stringify(next));
          return next;
        }),
      update: (patch) =>
        setPrefs((p) => {
          const next = { ...p, ...patch };
          localStorage.setItem("av-prefs", JSON.stringify(next));
          return next;
        }),
      reset: () => {
        setPrefs(DEFAULTS);
        localStorage.setItem("av-prefs", JSON.stringify(DEFAULTS));
      },
    }),
    [prefs],
  );

  return <PrefsCtx.Provider value={value}>{children}</PrefsCtx.Provider>;
}

export const usePrefs = () => useContext(PrefsCtx);
