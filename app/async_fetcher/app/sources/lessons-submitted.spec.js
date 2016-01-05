import expect from 'expect'
import sinon from 'sinon'
import Rx from 'rx'

import lessonsSubmitted from './lessons-submitted'

lessonsSubmitted.__Rewire__('githubClientFactory', (() => {
  const stub = sinon.stub()

  stub.withArgs('some-token').returns({
    issues: {
      repoIssues: (options, callback) => {
        callback(null, [
          {
            title: 'Lessons Feedback',
            number: 1,
            created_at: '2011-04-22T13:33:48Z'
          }, {
            title: 'Code Lab Feedback',
            number: 2,
            created_at: '2011-04-22T13:33:48Z'
          }, {
            title: 'Everything is broken!',
            number: 3,
            created_at: '2011-04-22T13:33:48Z'
          }
        ])
      }
    }
  })

  stub.withArgs('invalid-token').returns({
    issues: {
      repoIssues: (options, callback) => {
        callback(new Error('here is an error from GitHub'), null)
      }
    }
  })

  return stub
})())

lessonsSubmitted.__Rewire__('githubReposObserverFactory', (() => {
  const stub = sinon.stub()

  stub.withArgs('some-token').returns(
    Rx.Observable.fromArray([
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
  )

  stub.withArgs('some-token-with-no-repos').returns([])

  stub.withArgs('invalid-token').returns(
    Rx.Observable.throw(
      new Error('here is an error from GitHub')
    )
  )

  return stub
})())

describe('sources/lessons-submitted', () => {

  it('generates an observable', () => {
    const observable = lessonsSubmitted('some-token', {})
    expect(observable instanceof Rx.Observable).toEqual(true)
  })

  describe('the observable', () => {

    it('throws an error when GitHub returns an error', (done) => {
      const observable = lessonsSubmitted('invalid-token', {})

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

    it('adds extra issue attributes where a Code Lab Feedback issue is found', (done) => {
      let repos = []

      const observable = lessonsSubmitted('some-token', {})

      observable.subscribe(
        (repo) => { repos.push(repo) },
        (error) => { throw(error) },
        () => {
          expect(repos).toEqual([
            {
              issue: 2,
              name: 'codelab-static-laptop-setup',
              owner: 'chrisvfritz',
              status: 'submitted',
              submittedAt: '2011-04-22T13:33:48Z'
            }, {
              issue: 2,
              name: 'codelab-blahdy-blah',
              owner: 'chrisvfritz',
              status: 'submitted',
              submittedAt: '2011-04-22T13:33:48Z'
            }
          ])
          done()
        }
      )
    })
  })
})
