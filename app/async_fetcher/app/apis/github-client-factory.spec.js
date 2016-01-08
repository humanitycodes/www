import expect from 'expect'
import githubClientFactory from './github-client-factory'

describe('apis/github-client', () => {
  it('raises an error without a token', () => {
    expect(() => {
      githubClientFactory()
    }).toThrow('OAuth2 authentication requires a token or key & secret to be set')
  })

  it('works provided a string token', () => {
    const GithubClient = githubClientFactory('some-token')
    expect(GithubClient).toExist()
  })
})
