import versionhelper

fn main() {

    version1 := '1.1.1'
    version2 := '1.1.2'

    if versionhelper.eq(version1, version2) {
        println("versions are equal")
    }
    else {
        println("version are not equal")
    }

    // versionhelper.eq(version1, version2) == false
    // versionhelper.ne(version1, version2) == true
    // versionhelper.gt(version1, version2) == false
    // versionhelper.ge(version1, version2) == false
    // versionhelper.lt(version1, version2) == true
    // versionhelper.le(version1, version2) == true

    version_details := versionhelper.parse('1.1.1')
    println(version_details)

    /*

    output:

    versionhelper.Version{
        value: '1.1.1'
        major: 1
        minor: 1
        patch: 1
        alpha: 0
        alphapatch: 0
    }

    */
}