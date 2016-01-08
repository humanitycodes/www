import expect from 'expect'
import sinon from 'sinon'
import Rx from 'rx'

import lessonsApproved from './lessons-approved'

lessonsApproved.__Rewire__('githubClientFactory', (() => {
  const stub = sinon.stub()

  stub.withArgs('some-token').returns({
    issues: {
      getComments: (options, callback) => {
        callback(null, [
          {
            id: 1,
            body: 'something something',
          }, {
            id: 2,
            body: 'Looks good! :shipit: :smiley: :tada:',
          },
        ])
      },
    },
  })

  stub.withArgs('invalid-token').returns({
    issues: {
      getComments: (options, callback) => {
        callback(new Error('here is an error from GitHub'), null)
      },
    },
  })

  return stub
})())

lessonsApproved.__Rewire__('githubReposObserverFactory', (() => {
  const stub = sinon.stub()

  stub.withArgs('some-token').returns(
    Rx.Observable.fromArray([
      {
        issue: 2,
        name: 'codelab-static-laptop-setup',
        owner: 'chrisvfritz',
        status: 'approved',
        submittedAt: '2011-04-22T13:33:48Z',
        comment: 2,
        approvedAt: '2011-01-22T13:33:48Z',
      }, {
        issue: 2,
        name: 'codelab-blahdy-blah',
        owner: 'chrisvfritz',
        status: 'approved',
        submittedAt: '2011-04-22T13:33:48Z',
        comment: 2,
        approvedAt: '2011-01-22T13:33:48Z',
      },
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

describe('sources/lessons-approved', () => {
  it('generates an observable', () => {
    const observable = lessonsApproved('some-token', {})
    expect(observable instanceof Rx.Observable).toEqual(true)
  })

  describe('the observable', () => {
    it('throws an error when GitHub returns an error', (done) => {
      const observable = lessonsApproved('invalid-token', {})

      observable.subscribe(
        () => {},
        (error) => {
          expect(error).toEqual(
            new Error('here is an error from GitHub')
          )
          done()
        },
        () => { done() }
      )
    })

    it('adds extra issue attributes where an approving comment is found', (done) => {
      const repos = []

      const observable = lessonsApproved('some-token', {})

      observable.subscribe(
        (repo) => { repos.push(repo) },
        (error) => { throw error },
        () => {
          expect(repos).toEqual([
            {
              approvedAt: '2011-01-22T13:33:48Z',
              comment: 2,
              issue: 2,
              name: 'codelab-static-laptop-setup',
              owner: 'chrisvfritz',
              status: 'approved',
              submittedAt: '2011-04-22T13:33:48Z',
            }, {
              approvedAt: '2011-01-22T13:33:48Z',
              comment: 2,
              issue: 2,
              name: 'codelab-blahdy-blah',
              owner: 'chrisvfritz',
              status: 'approved',
              submittedAt: '2011-04-22T13:33:48Z',
            },
          ])
          done()
        }
      )
    })
  })
})
