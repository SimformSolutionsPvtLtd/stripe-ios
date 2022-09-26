//
// FinancialConnectionsSessionManifest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
@_spi(STP) import StripeCore

enum FinancialConnectionsPaymentMethodType: String, SafeEnumCodable, Equatable {
    case usBankAccount = "us_bank_account"
    case link = "link"
    case unparsable
}

struct FinancialConnectionsSessionManifest: Decodable {
    
    // MARK: - Types
    
    enum NextPane: String, SafeEnumCodable, Equatable {
        case accountPicker = "account_picker"
        case attachLinkedPaymentAccount = "attach_linked_payment_account"
        case authOptions = "auth_options"
        case consent = "consent"
        case institutionPicker = "institution_picker"
        case linkConsent = "link_consent"
        case linkLogin = "link_login"
        case manualEntry = "manual_entry"
        case manualEntrySuccess = "manual_entry_success"
        case networkingLinkLoginWarmup = "networking_link_login_warmup"
        case networkingLinkSignupPane = "networking_link_signup_pane"
        case networkingLinkVerification = "networking_link_verification"
        case partnerAuth = "partner_auth"
        case success = "success"
        case unexpectedError = "unexpected_error"
        case unparsable
        
        // client-side only panes
        case resetFlow = "reset_flow"
        case terminalError = "terminal_error"
    }
    
    // MARK: - Properties
    
    let accountholderIsLinkConsumer: Bool?
    let activeAuthSession: FinancialConnectionsAuthorizationSession?
    let activeInstitution: FinancialConnectionsInstitution?
    let allowManualEntry: Bool
    let businessName: String?
    let connectPlatformName: String?
    let consentRequired: Bool
    let customManualEntryHandling: Bool
    let disableLinkMoreAccounts: Bool
    let hostedAuthUrl: String
    let successUrl: String
    let cancelUrl: String
    let initialInstitution: FinancialConnectionsInstitution?
    let instantVerificationDisabled: Bool
    let institutionSearchDisabled: Bool
    let isLinkWithStripe: Bool?
    let isNetworkingUserFlow: Bool?
    let isStripeDirect: Bool?
    let livemode: Bool
    let manualEntryUsesMicrodeposits: Bool
    let nextPane: NextPane
    let permissions: [StripeAPI.FinancialConnectionsAccount.Permissions]
    let singleAccount: Bool
    let paymentMethodType: FinancialConnectionsPaymentMethodType?
}

struct FinancialConnectionsAuthorizationSession: Decodable {
    enum Flow: String, SafeEnumCodable, Equatable {
        case directWebview = "direct_webview"
        case finicityConnectV2Lite = "finicity_connect_v2_lite"
        case finicityConnectV2Oauth = "finicity_connect_v2_oauth"
        case finicityConnectV2OauthWebview = "finicity_connect_v2_oauth_webview"
        case finicityConnectV2OauthRedirect = "finicity_connect_v2_oauth_redirect"
        case mxConnect = "mx_connect"
        case mxOauth = "mx_oauth"
        case mxOauthWebview = "mx_oauth_webview"
        case testmode = "testmode"
        case testmodeOauth = "testmode_oauth"
        case testmodeOauthWebview = "testmode_oauth_webview"
        case truelayerEmbedded = "truelayer_embedded"
        case truelayerOauth = "truelayer_oauth"
        case wellsFargo = "wells_fargo"
        case unparsable
        
        func toInstitutionName() -> String? {
            switch self {
            case .finicityConnectV2Oauth:
                fallthrough
            case .finicityConnectV2OauthWebview:
                fallthrough
            case .finicityConnectV2Lite:
                fallthrough
            case .finicityConnectV2OauthRedirect:
                return "Finicity"
            case .mxConnect:
                fallthrough
            case .mxOauth:
                fallthrough
            case .mxOauthWebview:
                return "MX"
            case .truelayerEmbedded:
                fallthrough
            case .truelayerOauth:
                return "TrueLayer"
            case .wellsFargo:
                return "Wells Fargo"
            case .directWebview:
                fallthrough
            case .testmode:
                fallthrough
            case .testmodeOauth:
                fallthrough
            case .testmodeOauthWebview:
                fallthrough
            case .unparsable:
                assertionFailure("Expected to never access \(self)")
                return nil
            }
        }
        
        func isOAuth() -> Bool {
            switch self {
            case .directWebview:
                fallthrough
            case .finicityConnectV2Oauth:
                fallthrough
            case .finicityConnectV2OauthWebview:
                fallthrough
            case .finicityConnectV2OauthRedirect:
                fallthrough
            case .mxOauth:
                fallthrough
            case .mxOauthWebview:
                fallthrough
            case .testmodeOauth:
                fallthrough
            case .testmodeOauthWebview:
                fallthrough
            case .truelayerEmbedded:
                fallthrough
            case .truelayerOauth:
                fallthrough
            case .wellsFargo:
                return true
                
            case .finicityConnectV2Lite:
                fallthrough
            case .mxConnect:
                fallthrough
            case .testmode:
                fallthrough
            case .unparsable:
                return false
            }
        }
    }

    let id: String
    let flow: Flow?
    let institutionSkipAccountSelection: Bool?
    let nextPane: FinancialConnectionsSessionManifest.NextPane
    let showPartnerDisclosure: Bool?
    let skipAccountSelection: Bool?
    let url: String?
}

struct FinancialConnectionsMixedOAuthParams: Decodable {
    let state: String
    let code: String?
    let status: String?
    let memberGuid: String?
    let error: String?
}

struct FinancialConnectionsAuthorizationSessionAccounts: Decodable {
    let data: [FinancialConnectionsPartnerAccount]
    let nextPane: FinancialConnectionsSessionManifest.NextPane
}

struct FinancialConnectionsPartnerAccount: Decodable {
    let id: String
    let name: String
    let displayableAccountNumbers: String?
    let linkedAccountId: String? // determines whether we show a "Linked" label
    let balanceAmount: Double?
    let currency: String?
    let supportedPaymentMethodTypes: [FinancialConnectionsPaymentMethodType]
    
    var balanceInfo: (balanceAmount: Double, currency: String)? {
        if let balanceAmount = balanceAmount, let currency = currency {
            return (balanceAmount, currency)
        } else {
            return nil
        }
    }
}

struct FinancialConnectionsDisabledPartnerAccount {
    let account: FinancialConnectionsPartnerAccount
    let disableReason: String
}

typealias MicrodepositVerificationMethod = FinancialConnectionsPaymentAccountResource.MicrodepositVerificationMethod
struct FinancialConnectionsPaymentAccountResource: Decodable {
    
    enum MicrodepositVerificationMethod: String, SafeEnumCodable, Equatable {
        case descriptorCode = "descriptor_code"
        case amounts = "amounts"
        case unparsable
    }

    let id: String
    let nextPane: FinancialConnectionsSessionManifest.NextPane
    let microdepositVerificationMethod: MicrodepositVerificationMethod
    let eligibleForNetworking: Bool?
    let networkingSuccessful: Bool?
}
