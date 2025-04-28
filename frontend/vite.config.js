import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  base: '/build/',
  plugins: [react()],
  build: {
    outDir: 'dist',
    assetsDir: '',
    manifest: true,
    rollupOptions: {
      output: {
        manualChunks: undefined,
      },
    },
  }
})
