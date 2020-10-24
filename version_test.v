module version

fn test_eq() {
	assert eq('1.0.0', '1.0') == true
	assert eq('1.1.1', 'stable-1.1.1') == true
	assert eq('1.1.1', '1.1.1') == true
	assert eq('1.1.1', 'v1.1.1') == true
	assert eq('1.1.1-alpha', 'v1.1.1-alpha') == true
	assert eq('1.1.1-alpha1', 'v1.1.1-alpha1') == true
}

fn test_ne() {
	assert ne('1.1.1', '1.1.1') == false
	assert ne('1.1.1', '1.1.1alpha') == true
	assert ne('1.1.1alpha', '1.1.1alpha3') == true
	assert ne('1.1.1', '1.1.2') == true
	assert ne('1.1.1', '1.2.1') == true
	assert ne('1.1.1', '2.1.1') == true
}

fn test_lt() {
	assert lt('1.1.1', '1.1.1') == false
	assert lt('1.1.0-alpha0', '1.1.1-alpha1') == true
	assert lt('1.1.0-alpha1', '1.1.1-beta1') == true
	assert lt('1.1.0-alpha1', '1.1.1-alpha1') == true
	assert lt('1.0.1-alpha1', '1.1.1-alpha1') == true
	assert lt('0.1.1-alpha1', '1.1.1-alpha1') == true
	assert lt('1.1.0-alpha2', '1.1.1-alpha1') == true
	assert lt('1.1.0-gamma1', '1.1.1-beta1') == true
	assert lt('1.1.2-alpha1', '1.1.1-alpha1') == false
	assert lt('1.2.1-alpha1', '1.1.1-alpha1') == false
	assert lt('2.1.1-alpha1', '1.1.1-alpha1') == false

    // greek suffix
	assert lt('1.1.1-beta1', '1.1.1-delta1') == true
	assert lt('1.1.1-gamma1', '1.1.1-delta1') == true
    assert lt('1.1.1-omega', '1.1.1-delta1') == false

    // fallback suffix
	assert lt('1.1.1-aaa1', '1.1.1-bbb1') == true
	assert lt('1.1.1-zzz1', '1.1.1-bbb1') == false
}

fn test_le() {
	assert le('1.1.1-alpha1', '1.1.1-alpha1') == true
	assert le('1.1.0-alpha0', '1.1.1-alpha1') == true
	assert le('1.1.0-alpha1', '1.1.1-beta1') == true
	assert le('1.1.0-alpha1', '1.1.1-alpha1') == true
	assert le('1.0.1-alpha1', '1.1.1-alpha1') == true
	assert le('0.1.1-alpha1', '1.1.1-alpha1') == true
	assert le('1.1.1-alpha2', '1.1.1-alpha1') == false
	assert le('1.1.1-gamma1', '1.1.1-beta1') == false
	assert le('1.1.2-alpha1', '1.1.1-alpha1') == false
	assert le('1.2.1-alpha1', '1.1.1-alpha1') == false
	assert le('2.1.1-alpha1', '1.1.1-alpha1') == false

    // greek suffix
    assert lt('1.1.1-beta1', '1.1.1-delta1') == true
    assert lt('1.1.1-gamma1', '1.1.1-delta1') == true
    assert lt('1.1.1-omega', '1.1.1-delta1') == false

    // fallback suffix
    assert lt('1.1.1-aaa1', '1.1.1-bbb1') == true
    assert lt('1.1.1-zzz1', '1.1.1-bbb1') == false
}

fn test_gt() {
	assert gt('1.1.1-alpha1', '1.1.1-alpha1') == false
	assert gt('1.1.0-alpha0', '1.1.1-alpha1') == false
	assert gt('1.1.0-alpha1', '1.1.1-beta1') == false
	assert gt('1.1.0-alpha1', '1.1.1-alpha1') == false
	assert gt('1.0.1-alpha1', '1.1.1-alpha1') == false
	assert gt('0.1.1-alpha1', '1.1.1-alpha1') == false
	assert gt('1.1.1-alpha2', '1.1.1-alpha1') == true
	assert gt('1.1.1-gamma1', '1.1.1-beta1') == true
	assert gt('1.1.2-alpha1', '1.1.1-alpha1') == true
	assert gt('1.2.1-alpha1', '1.1.1-alpha1') == true
	assert gt('2.1.1-alpha1', '1.1.1-alpha1') == true

    // greek suffix
    assert gt('1.1.1-beta1', '1.1.1-delta1') == false
    assert gt('1.1.1-gamma1', '1.1.1-delta1') == false
    assert gt('1.1.1-omega', '1.1.1-delta1') == true

    // fallback suffix
    assert gt('1.1.1-aaa1', '1.1.1-bbb1') == false
    assert gt('1.1.1-zzz1', '1.1.1-bbb1') == true
}

fn test_ge() {
	assert ge('1.1.1-alpha1', '1.1.1-alpha1') == true
	assert ge('1.1.0-alpha0', '1.1.1-alpha1') == false
	assert ge('1.1.0-alpha1', '1.1.1-beta1') == false
	assert ge('1.1.0-alpha1', '1.1.1-alpha1') == false
	assert ge('1.0.1-alpha1', '1.1.1-alpha1') == false
	assert ge('0.1.1-alpha1', '1.1.1-alpha1') == false
	assert ge('1.1.1-alpha2', '1.1.1-alpha1') == true
	assert ge('1.1.1-gamma1', '1.1.1-beta1') == true
	assert ge('1.1.2-alpha1', '1.1.1-alpha1') == true
	assert ge('1.2.1-alpha1', '1.1.1-alpha1') == true
	assert ge('2.1.1-alpha1', '1.1.1-alpha1') == true

    // greek suffix
    assert ge('1.1.1-beta1', '1.1.1-delta1') == false
    assert ge('1.1.1-gamma1', '1.1.1-delta1') == false
    assert ge('1.1.1-omega', '1.1.1-delta1') == true

    // fallback suffix
    assert ge('1.1.1-aaa1', '1.1.1-bbb1') == false
    assert ge('1.1.1-zzz1', '1.1.1-bbb1') == true
}
