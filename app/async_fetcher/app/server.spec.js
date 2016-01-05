import expect from 'expect'
import testRequest from 'supertest'
import Rx from 'rx'
import server from './server'

server.__Rewire__('githubReposObserverFactory', () => {
  return Rx.Observable.fromArray([
    {
      approvedAt: '2011-01-22T13:33:48Z',
      comment: 2,
      issue: 2,
      name: 'codelab-static-laptop-setup',
      owner: 'chrisvfritz',
      status: 'approved',
      submittedAt: '2011-04-22T13:33:48Z'
    },
    {
      approvedAt: '2011-01-22T13:33:48Z',
      comment: 2,
      issue: 2,
      name: 'codelab-blahdy-blah',
      owner: 'chrisvfritz',
      status: 'approved',
      submittedAt: '2011-04-22T13:33:48Z'
    }
  ])
})

describe('server', () => {

  before(function(done) {
    server.start((app) => {
      this.app = app
      done()
    })
  })

  after(function() {
    this.app.close()
  })

  it('has a valid lesson-repos route', function(done) {
    testRequest(this.app)
      .get('/lesson-repos/some-token')
      .set('Accept', 'application/json')
      .expect('Content-Type', /json/)
      .expect(200)
      .end((error, response) => {
        expect(response.body).toEqual({
          lessons: {
            'blahdy-blah': 'approved',
            'static-laptop-setup': 'approved'
          }
        })
        done()
      })
  })

  it('has a valid projects route', function(done) {
    testRequest(this.app)
      .get('/projects/some-token')
      .set('Accept', 'application/json')
      .expect('Content-Type', /json/)
      .expect(200)
      .end((error, response) => {
        expect(response.body).toEqual({
          lessons: {
            'blahdy-blah': {
              'approvedAt': '2011-01-22T13:33:48Z',
              'comment': 2,
              'issue': 2,
              'status': 'approved',
              'submittedAt': '2011-04-22T13:33:48Z'
            },
            'static-laptop-setup': {
              approvedAt: '2011-01-22T13:33:48Z',
              comment: 2,
              issue: 2,
              status: 'approved',
              submittedAt: '2011-04-22T13:33:48Z'
            }
          }
        })
        done()
      })
  })

})
