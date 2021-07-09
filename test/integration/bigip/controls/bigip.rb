# run some of the tests
require_controls 'big-ip-atc-ready' do
    control 'bigip-connectivity'
    control 'bigip-declarative-onboarding'
    control 'bigip-licensed'
end