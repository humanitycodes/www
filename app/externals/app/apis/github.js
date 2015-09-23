import GitHubApi from 'github'

export default (token) => {
  const client = new GitHubApi({
    version: "3.0.0",
    debug: process.env.DEBUG,
    protocol: "https",
    host: "api.github.com",
    timeout: 5000,
    headers: { "user-agent": "CodeLab" }
  })

  client.authenticate({
    type: 'oauth',
    token: token
    // key: process.env.OMNIAUTH_GITHUB_KEY || '571930b8726dcdddfae7',
    // secret: process.env.OMNIAUTH_GITHUB_SECRET || 'ccd156a9d8645b31ac3be0820cbd287fcc06c759'
  })

  return client
}
