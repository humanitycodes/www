import expect from 'expect'
import sinon from 'sinon'
import Rx from 'rx'

import lessonsStarted from './lessons-started'

lessonsStarted.__Rewire__('githubClientFactory', (() => {
  const stub = sinon.stub()

  stub.withArgs('some-token').returns({
    repos: {
      getAll: (options, callback) => {
        callback(null, [
          {
            name: 'some-other-repo',
            owner: {
              login: 'chrisvfritz',
            }
          }, {
            name: 'codelab-static-laptop-setup',
            owner: {
              login: 'chrisvfritz',
            }
          }, {
            name: 'and-yet-another-repo',
            owner: {
              login: 'chrisvfritz',
            }
          }, {
            name: 'codelab-blahdy-blah',
            owner: {
              login: 'chrisvfritz',
            }
          }
        ])
      }
    }
  })

  stub.withArgs('invalid-token').returns({
    repos: {
      getAll: (options, callback) => {
        callback(new Error('here is an error from GitHub'), null)
      }
    }
  })

  return stub
})())

describe('sources/lessons-started', () => {

  it('generates an observable', () => {
    const observable = lessonsStarted('some-token', {})
    expect(observable instanceof Rx.Observable).toEqual(true)
  })

  describe('the observable', () => {

    it('throws an error when GitHub returns an error', (done) => {
      const observable = lessonsStarted('invalid-token', {})

      observable.subscribe(
        (repo) => {},
        (error) => {
          expect(error).toEqual(
            new Error('here is an error from GitHub')
          )
          done()
        },
        () => { done() }
      )
    })

    it('filters out non-codelab repos', (done) => {
      let repos = []

      const observable = lessonsStarted('some-token', {})

      observable.subscribe(
        (repo) => { repos.push(repo) },
        (error) => { throw(error) },
        () => {
          expect(repos).toEqual([
            {
              name: 'codelab-static-laptop-setup',
              owner: 'chrisvfritz',
              status: 'started'
            }, {
              name: 'codelab-blahdy-blah',
              owner: 'chrisvfritz',
              status: 'started'
            }
          ])
          done()
        }
      )
    })

    it('finds only a single repo when `query.single` is set', (done) => {
      let repos = []

      const observable = lessonsStarted('some-token', {
        single: 'static-laptop-setup'
      })

      observable.subscribe(
        (repo) => { repos.push(repo) },
        (error) => { throw(error) },
        () => {
          expect(repos).toEqual([
            {
              name: 'codelab-static-laptop-setup',
              owner: 'chrisvfritz',
              status: 'started'
            }
          ])
          done()
        }
      )
    })

    it('filters out non-key repos when `query.keys` is set', (done) => {
      let repos = []

      const observable = lessonsStarted('some-token', {
        keys: 'static-laptop-setup'
      })

      observable.subscribe(
        (repo) => { repos.push(repo) },
        (error) => { throw(error) },
        () => {
          expect(repos).toEqual([
            {
              name: 'codelab-static-laptop-setup',
              owner: 'chrisvfritz',
              status: 'started'
            }
          ])
          done()
        }
      )
    })

    it('filters out non-key repos when `query.only` is set to a single key', (done) => {
      let repos = []

      const observable = lessonsStarted('some-token', {
        only: 'static-laptop-setup'
      })

      observable.subscribe(
        (repo) => { repos.push(repo) },
        (error) => { throw(error) },
        () => {
          expect(repos).toEqual([
            {
              name: 'codelab-static-laptop-setup',
              owner: 'chrisvfritz',
              status: 'started'
            }
          ])
          done()
        }
      )
    })

    it('filters out non-key repos when `query.only` is set to multiple keys', (done) => {
      let repos = []

      const observable = lessonsStarted('some-token', {
        only: 'ruby-laptop-setup,static-laptop-setup'
      })

      observable.subscribe(
        (repo) => { repos.push(repo) },
        (error) => { throw(error) },
        () => {
          expect(repos).toEqual([
            {
              name: 'codelab-static-laptop-setup',
              owner: 'chrisvfritz',
              status: 'started'
            }
          ])
          done()
        }
      )
    })

    it('ignores `query.keys` when `query.single` is set', (done) => {
      let repos = []

      const observable = lessonsStarted('some-token', {
        single: 'blahdy-blah',
        keys: 'static-laptop-setup'
      })

      observable.subscribe(
        (repo) => { repos.push(repo) },
        (error) => { throw(error) },
        () => {
          expect(repos).toEqual([
            {
              name: 'codelab-blahdy-blah',
              owner: 'chrisvfritz',
              status: 'started'
            }
          ])
          done()
        }
      )
    })
  })
})
