module.exports = {
  purge: {
    enabled: true,
    content: ['app/**/*.html.erb',
      'app/javascript/**/*.js',
    ],
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        gray: {
          dark: '#0F172A',
          light: '#64748B',
          cool: '#30363d',
          blue: '#081e36'
        }
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
