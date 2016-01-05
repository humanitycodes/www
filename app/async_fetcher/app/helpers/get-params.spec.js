import expect from 'expect'
import getParams from './get-params'

describe('helpers/get-params', () => {

  it('correctly parses a text query from a request into an object', () => {
    const request = {
      _url: {
        query: 'a=b&c=d&e=f'
      }
    }

    const actual = getParams(request)
    const expected = {
      a: 'b',
      c: 'd',
      e: 'f'
    }

    expect(actual).toEqual(expected)
  })

  it('returns an empty object when no query exists', () => {
    const request = {
      _url: {}
    }

    const actual = getParams(request)
    const expected = {}

    expect(actual).toEqual(expected)
  })

})
