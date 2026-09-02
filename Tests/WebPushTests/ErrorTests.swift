//
//  ErrorTests.swift
//  swift-webpush
//
//  Created by Dimitri Bouniol on 2024-12-21.
//  Copyright © 2024 Mochi Development, Inc. All rights reserved.
//

import AsyncHTTPClient
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import Testing
@testable import WebPush

@Suite struct ErrorTests {
    @Test func badSubscriberError() {
        #expect(BadSubscriberError() == BadSubscriberError())
    }
    
    @Test func base64URLDecodingError() {
        #expect(Base64URLDecodingError() == Base64URLDecodingError())
    }
    
    @Test func pushServiceError() {
        let response = HTTPClientResponse(status: .notFound)
        #expect(PushServiceError(response: response) == PushServiceError(response: response))
        #expect(PushServiceError(response: response).hashValue == PushServiceError(response: response).hashValue)
        #expect(PushServiceError(response: response) != PushServiceError(response: HTTPClientResponse(status: .internalServerError)))
    }
    
    @Test func messageTooLargeError() {
        #expect(MessageTooLargeError() == MessageTooLargeError())
    }
    
    @Test func userAgentKeyMaterialError() {
        #expect(UserAgentKeyMaterialError.invalidPublicKey(underlyingError: Base64URLDecodingError()) == .invalidPublicKey(underlyingError: Base64URLDecodingError()))
        #expect(UserAgentKeyMaterialError.invalidPublicKey(underlyingError: Base64URLDecodingError()).hashValue == UserAgentKeyMaterialError.invalidPublicKey(underlyingError: Base64URLDecodingError()).hashValue)
        #expect(UserAgentKeyMaterialError.invalidPublicKey(underlyingError: Base64URLDecodingError()) != .invalidPublicKey(underlyingError: BadSubscriberError()))
        #expect(UserAgentKeyMaterialError.invalidAuthenticationSecret(underlyingError: Base64URLDecodingError()) == .invalidAuthenticationSecret(underlyingError: Base64URLDecodingError()))
        #expect(UserAgentKeyMaterialError.invalidAuthenticationSecret(underlyingError: Base64URLDecodingError()).hashValue == UserAgentKeyMaterialError.invalidAuthenticationSecret(underlyingError: Base64URLDecodingError()).hashValue)
        #expect(UserAgentKeyMaterialError.invalidAuthenticationSecret(underlyingError: Base64URLDecodingError()) != .invalidAuthenticationSecret(underlyingError: BadSubscriberError()))
        #expect(UserAgentKeyMaterialError.invalidPublicKey(underlyingError: Base64URLDecodingError()) != .invalidAuthenticationSecret(underlyingError: Base64URLDecodingError()))
    }
    
    @Test func vapidConfigurationError() {
        #expect(VAPID.ConfigurationError.keysNotProvided == .keysNotProvided)
        #expect(VAPID.ConfigurationError.matchingKeyNotFound == .matchingKeyNotFound)
        #expect(VAPID.ConfigurationError.keysNotProvided != .matchingKeyNotFound)
    }
}
