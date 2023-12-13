const { defineConfig } = require('cypress')

module.exports = defineConfig({
  e2e: {
    projectId: 'resume',
    baseUrl: 'http://localhost:3000',
    // supportFile: 'cypress/support/index.js',
    specPattern: 'cypress/e2e/*.spec.js',
  },

  // Environment variables can be defined here
  env: {
    apiEndpoint: 'https://05uebzxorc.execute-api.ap-northeast-1.amazonaws.com/cloud_resume_stage/countVisitor',
  },

  // Configure plugins heres
  setupNodeEvents(on, config) {
    // Handle events or add custom tasks
  },
});