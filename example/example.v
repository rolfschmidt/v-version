import version

fn main() {
	version1 := '1.1.1'
	version2 := '1.1.2'

	if version.eq(version1, version2) {
		println('versions are equal')
	} else {
		println('version are not equal')
	}

	// version.eq(version1, version2) == false
	// version.ne(version1, version2) == true
	// version.gt(version1, version2) == false
	// version.ge(version1, version2) == false
	// version.lt(version1, version2) == true
	// version.le(version1, version2) == true

	version_details := version.parse('1.1.1')
	println(version_details)

	/*

    output:

    version.Version{
        value: '1.1.1'
        major: 1
        minor: 1
        patch: 1
        suffix: 0
        suffixpatch: 0
    }

    */
}
