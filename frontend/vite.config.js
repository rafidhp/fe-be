import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  base: "",
  plugins: [react()],
  build: {
    assetsDir: "",
    manifest: "manifest.json",
    outDir: "dist",
    rollupOptions: {
      input: "./src/main.jsx",
      output: {
        manualChunks: undefined,
      },
    },
  },
});
