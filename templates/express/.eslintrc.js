module.exports = {
  root: true,
  env: {
    node: true
  },
  plugins: ['node'],
  extends: ['airbnb-base', 'prettier'],
  rules: {
    'comma-dangle': 0,
    'prefer-promise-reject-errors': 0,
    'import/extensions': 0,
    'no-shadow': 0,
    'arrow-parens': 0,
    'no-underscore-dangle': 0,
    'no-param-reassign': 0
  }
};
