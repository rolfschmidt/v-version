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

pub fn parse(version_string string) Version {
	query := r'^(?:[a-zA-Z]|-|_)*(\d+)(?:\.(\d+))?(?:\.(\d+))?(?:[-_]?([a-zA-Z]*)(\d+)?)?$'
	mut re := regex.regex_opt(query) or { panic(err) }
	start, _ := re.match_string(version_string)
	if start == -1 {
		panic('Invalid version format! ${version_string}')
	}
	mut result := Version{
		value: version_string
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
		part := '${version_string[re.groups[gi]..re.groups[gi + 1]]}'
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

pub fn (self Version) eq(other Version) bool {
	return self.major == other.major && self.minor == other.minor && self.patch == other.patch
		&& self.suffix == other.suffix && self.suffixpatch == other.suffixpatch
}

pub fn (self Version) ne(other Version) bool {
	return self.major != other.major || self.minor != other.minor || self.patch != other.patch
		|| self.suffix != other.suffix || self.suffixpatch != other.suffixpatch
}

pub fn (self Version) lt(other Version) bool {
	if self.major < other.major {
		return true
	}
	if self.major == other.major && self.minor < other.minor {
		return true
	}
	if self.major == other.major && self.minor == other.minor && self.patch < other.patch {
		return true
	}
	if self.major == other.major && self.minor == other.minor && self.patch == other.patch
		&& self.suffix < other.suffix {
		return true
	}
	if self.major == other.major && self.minor == other.minor && self.patch == other.patch
		&& self.suffix == other.suffix && self.suffixpatch < other.suffixpatch {
		return true
	}
	return false
}

pub fn (self Version) gt(other Version) bool {
	if self.major > other.major {
		return true
	}
	if self.major == other.major && self.minor > other.minor {
		return true
	}
	if self.major == other.major && self.minor == other.minor && self.patch > other.patch {
		return true
	}
	if self.major == other.major && self.minor == other.minor && self.patch == other.patch
		&& self.suffix > other.suffix {
		return true
	}
	if self.major == other.major && self.minor == other.minor && self.patch == other.patch
		&& self.suffix == other.suffix && self.suffixpatch > other.suffixpatch {
		return true
	}
	return false
}

pub fn (self Version) le(other Version) bool {
	if self.eq(other) {
		return true
	}
	return self.lt(other)
}

pub fn (self Version) ge(other Version) bool {
	if self.eq(other) {
		return true
	}
	return self.gt(other)
}
