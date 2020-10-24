module version

import regex

struct Version {
pub mut:
	value       string
	major       int
	minor       int
	patch       int
	suffix      int
	suffixpatch int
}

pub fn eq(value1 string, value2 string) bool {
	v1 := parse(value1)
	v2 := parse(value2)
	return v1.eq(v2)
}

pub fn ne(value1 string, value2 string) bool {
	v1 := parse(value1)
	v2 := parse(value2)
	return v1.ne(v2)
}

pub fn lt(value1 string, value2 string) bool {
	v1 := parse(value1)
	v2 := parse(value2)
	return v1.lt(v2)
}

pub fn le(value1 string, value2 string) bool {
	v1 := parse(value1)
	v2 := parse(value2)
	return v1.le(v2)
}

pub fn gt(value1 string, value2 string) bool {
	v1 := parse(value1)
	v2 := parse(value2)
	return v1.gt(v2)
}

pub fn ge(value1 string, value2 string) bool {
	v1 := parse(value1)
	v2 := parse(value2)
	return v1.ge(v2)
}

pub fn suffix(value string) int {
	return match value {
		'alpha' { 1 }
		'beta' { 2 }
		'gamma' { 3 }
		'delta' { 4 }
		'epsilon' { 5 }
		'zeta' { 6 }
		'eta' { 7 }
		'theta' { 8 }
		'iota' { 9 }
		'kappa' { 10 }
		'lambda' { 11 }
		'mu' { 12 }
		'nu' { 13 }
		'xi' { 14 }
		'omicron' { 15 }
		'pi' { 16 }
		'rho' { 17 }
		'sigma' { 18 }
		'tau' { 19 }
		'upsilon' { 20 }
		'phi' { 21 }
		'chi' { 22 }
		'psi' { 23 }
		'omega' { 24 }
		else { value.hash() }
	}
}

pub fn parse(version string) Version {
	query := r'^(?:[a-zA-Z]|-|_)*(\d+)(?:\.(\d+))?(?:\.(\d+))?(?:[-_]?([a-zA-Z]*)(\d+)?)?$'
	mut re := regex.regex_opt(query) or {
		panic(err)
	}
	start, end := re.match_string(version)
	if start == -1 {
		panic('Invalid version format! $version')
	}
	mut result := Version{
		value: version
		major: 0
		minor: 0
		patch: 0
		suffix: 0
		suffixpatch: 0
	}
	for gi := 0; gi < re.groups.len; gi += 2 {
		if re.groups[gi] < 0 {
			continue
		}
		part := '${version[re.groups[gi]..re.groups[gi + 1]]}'
		match gi {
			0 { result.major = part.int() }
			2 { result.minor = part.int() }
			4 { result.patch = part.int() }
			6 { result.suffix = suffix(part) }
			8 { result.suffixpatch = part.int() }
			else {}
		}
	}
	return result
}

pub fn (version Version) eq(cmp_version Version) bool {
	return version.major == cmp_version.major &&
		version.minor == cmp_version.minor && version.patch == cmp_version.patch && version.suffix ==
		cmp_version.suffix && version.suffixpatch == cmp_version.suffixpatch
}

pub fn (version Version) ne(cmp_version Version) bool {
	return version.major != cmp_version.major ||
		version.minor != cmp_version.minor || version.patch != cmp_version.patch || version.suffix !=
		cmp_version.suffix || version.suffixpatch != cmp_version.suffixpatch
}

pub fn (version Version) lt(cmp_version Version) bool {
	if version.major < cmp_version.major {
		return true
	}
	if version.major == cmp_version.major && version.minor < cmp_version.minor {
		return true
	}
	if version.major == cmp_version.major &&
		version.minor == cmp_version.minor && version.patch < cmp_version.patch {
		return true
	}
	if version.major == cmp_version.major &&
		version.minor == cmp_version.minor && version.patch == cmp_version.patch && version.suffix < cmp_version.suffix {
		return true
	}
	if version.major == cmp_version.major &&
		version.minor == cmp_version.minor && version.patch == cmp_version.patch && version.suffix ==
		cmp_version.suffix && version.suffixpatch < cmp_version.suffixpatch {
		return true
	}
	return false
}

pub fn (version Version) gt(cmp_version Version) bool {
	if version.major > cmp_version.major {
		return true
	}
	if version.major == cmp_version.major && version.minor > cmp_version.minor {
		return true
	}
	if version.major == cmp_version.major &&
		version.minor == cmp_version.minor && version.patch > cmp_version.patch {
		return true
	}
	if version.major == cmp_version.major &&
		version.minor == cmp_version.minor && version.patch == cmp_version.patch && version.suffix > cmp_version.suffix {
		return true
	}
	if version.major == cmp_version.major &&
		version.minor == cmp_version.minor && version.patch == cmp_version.patch && version.suffix ==
		cmp_version.suffix && version.suffixpatch > cmp_version.suffixpatch {
		return true
	}
	return false
}

pub fn (version Version) le(cmp_version Version) bool {
	if version.eq(cmp_version) {
		return true
	}
	return version.lt(cmp_version)
}

pub fn (version Version) ge(cmp_version Version) bool {
	if version.eq(cmp_version) {
		return true
	}
	return version.gt(cmp_version)
}
