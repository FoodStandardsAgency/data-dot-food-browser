module.exports = {
  ci: {
    collect: {
      startServerCommand: 'FSA_DATA_DOT_FOOD_API_URL=http://fsa-staging-catalog.epimorphics.net rails server',
      url: ['http://localhost:3000'],
      numberOfRuns: 3
    },
    assert: {
      assertions: {
        'categories:performance': ['warn', { minScore: 1 }],
        'categories:accessibility': ['error', { minScore: 1 }]
      }
    },
    upload: {
      target: 'temporary-public-storage'
    }
  }
}
