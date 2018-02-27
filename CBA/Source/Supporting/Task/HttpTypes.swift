//
//  HttpTypes.swift
//
//  Created by Saddam on 15/02/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation

// MARK: - HttpStatus enum

enum HttpStatus: Int {
    
    case httpStatusNoInternet      = 10
    case httpStatusContinue        = 100
    case httpStatusSwitchingProtocol = 101
    case httpStatusProcessing       = 102
    case httpStatusRequestURLLong   = 122
    case httpStatusOk               = 200
    case httpStatusCreated          = 201
    case httpStatusAccepted         = 202
    case httpStatusNonAuthoritativeInfo = 203
    case httpStatusNoContent            = 204
    case httpStatusResetContent         = 205
    case httpStatusPartialContent                 = 206
    case httpStatusMultiStatus          = 207
    case httpStatusIMUsed               = 226
    case httpStatusMultipleChoice       = 300
    case httpStatusMovedPermanently      = 301
    case httpStatusFound                = 302
    case httpStatusSeeOther             = 303
    case httpStatusNotModified          = 304
    case httpStatusUseProxy             = 305
    case httpStatusSwitfhProxy          = 306
    case httpStatusTemporaryRedirect    = 307
    case httpStatusBadRequest      = 400
    case httpStatusUnauthenticated = 401
    case httpStatusPaymentRequired  = 402
    case httpStatusUnauthorized    = 403
    case httpStatusNotFound        = 404
    case httpMethodNotSupported    = 405
    case httpNotAcceptable         = 406
    case httpStatusProxyAuthRequired    = 407
    case httpStatusRequestTimeout       = 408
    case httpStatusConflict        = 409
    case httpStatusGone             = 410
    case httpStatusLengthRequired    = 411
    case httpStatusOutdated        = 412
    case httpStatusRequestEntityTooLarge = 413
    case httpStatusURItooLong   = 414
    case httpNotSupportedMedia     = 415
    case httpStatusReqestRange      = 416
    case httpStatusExpectationFailed = 417
    case httpStatusIamTeaPot       = 418
    case httpStatusUnProcessableEntity  = 422
    case httpStatusLocked               = 423
    case httpStatusFailedDependency     = 424
    case httpStatusUnorderedCollection  = 425
    case httpStatusUpgradeRequired      = 426
    
    case httpStatusTooManyRequest        = 429
    case httpStatusNoResponse           = 444
    case httpStatusRetry               = 449
    case httpStatusBlockedByWindowsParentalControl  = 450
    case httpStatusClientClosedRequest  = 499
    case httpUnexpectedError       = 500
    case httpStatusNoImplemented = 501
    case httpDependentServiceError = 502
    case httpServiceUnavailable    = 503
    case httpGatewayTimeOut        = 504
    case httpStatusHttpVersionNotSupported = 505
    case httpStatusVariabtAlsoNegotiate = 506
    case httpStatusInsufficientStorage = 507
    case httpStatusBandWidthLimit   = 509
    case httpStatusNotExtended          = 510
    case httpUnknown               = 0        
}

// MARK: - HttpMethod enum

enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

// MARK: - MIMEType enum

enum MIMEType: String {
    case TextHtml                       = "text/html"
    case ApplicationJSON                = "application/json"
    case ApplicationXWWWFormURLEncoded  = "application/x-www-form-urlencoded"
    case ApplicationXML                 = "application/xml"
    case ApplicationOctetStream         = "application/octet-stream"
    case ImagePNG                       = "image/png"
    case ImageJPEG                      = "image/jpeg"
    case ImageANY                       = "image/*"
    case ApplicationJSONWithUTF8        = "application/json; charset=utf-8"
    case Gzip                           = "gzip"
}

struct HttpHeader {
    static let Accept               = "Accept"
    static let ContentType          = "Content-Type"
    static let CustomContentType    = "contenttype"
    static let AcceptEncoding       = "Accept-Encoding"
    static let APIKey               = "x-api-key"
    static let Authorization        = "Authorization"
    static let Authheader           = "authheader"
}
