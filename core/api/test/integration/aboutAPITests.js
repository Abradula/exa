'use strict'

/* eslint-env mocha */

import request from 'supertest'
import {promisify} from 'util'

import * as server from '../../src/server'
import * as testUtils from '../utils'
import {BASE_URL, SERVER_PORTS} from '../constants'

describe('API Integration Tests', () =>
  describe('About Information REST Api Testing', () => {
    let authDetails = {}

    before(async () => {
      await testUtils.setupTestUsers()
      await promisify(server.start)({apiPort: SERVER_PORTS.apiPort})

      authDetails = testUtils.getAuthDetails()
    })

    after(async () => {
      await Promise.all([
        promisify(server.stop)(),
        testUtils.cleanupTestUsers()
      ])
    })

    describe('*getAboutInformation', () => {
      it('should fetch core version and return status 200', async () => {
        const res = await request(BASE_URL)
          .get('/about')
          .set('auth-username', testUtils.rootUser.email)
          .set('auth-ts', authDetails.authTS)
          .set('auth-salt', authDetails.authSalt)
          .set('auth-token', authDetails.authToken)
          .expect(200)

        res.body.should.have.property('currentCoreVersion')
      })

      it('should return 404 if not found', async () => {
        await request(BASE_URL)
          .get('/about/bleh')
          .set('auth-username', testUtils.rootUser.email)
          .set('auth-ts', authDetails.authTS)
          .set('auth-salt', authDetails.authSalt)
          .set('auth-token', authDetails.authToken)
          .expect(404)
      })
    })
  }))
