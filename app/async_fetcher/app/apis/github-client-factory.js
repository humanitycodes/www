import GitHubApi from 'github'

export default (token) => {
  const client = new GitHubApi({
    version: '3.0.0',
    debug: process.env.DEBUG,
    protocol: 'https',
    host: 'api.github.com',
    timeout: 5000,
    headers: { 'user-agent': 'CodeLab' }
  })

  client.authenticate({
    type: 'oauth',
    token
  })

  return client
}
