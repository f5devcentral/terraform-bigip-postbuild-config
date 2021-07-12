# run some of the tests
require_controls 'big-ip-atc-ready' do
    control 'bigip-connectivity'
    control 'bigip-declarative-onboarding'
    control 'bigip-declarative-onboarding-version'
    control 'bigip-application-services'
    control 'bigip-application-services-version'
    control 'bigip-telemetry-streaming'
    control 'bigip-telemetry-streaming-version'
    control 'bigip-fast'
    control 'bigip-fast-version'
    control 'bigip-licensed'
  end