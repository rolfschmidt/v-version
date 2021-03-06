# version

This module provides the functionality to parse version strings and compare them.

## Installation

You can install this module using `v install rolfschmidt.version`, and
then use it with `import rolfschmidt.version` .

When there are updates, you can update with `v update rolfschmidt.version` .

You can also just run `v install rolfschmidt.version` again.

## Formats

These are the supported version formats:

```
(ignored prefix)(major).(minor).(patch)(suffix)(suffixpatch)
1
1.0
1.0.0
1.0.0a
1.0.0alpha
1.0.0alpha3
1.0.0-alpha
1.0.0-alpha3
1.0.0_alpha
1.0.0_alpha3
v1.0
stable-1.0
```

### Suffix format

It supports greek numbers and there is also a fallback for generic strings.

```
# greek style (alpha, beta, gamma, delta, epsilon, zeta, eta, theta, iota, kappa, lambda, mu, nu, xi, omicron, pi, rho, sigma, tau, upsilon, phi, chi, psi, omega)
version.lt('1.1.1-beta1', '1.1.1-delta1') // true
version.lt('1.1.1-gamma1', '1.1.1-delta1') // true
version.lt('1.1.1-omega', '1.1.1-delta1') // false

# generic
version.lt('1.1.1-aaa1', '1.1.1-bbb1') // true
version.lt('1.1.1-zzz1', '1.1.1-bbb1') // false
```

## Usage

```v
import version

fn main() {

    version1 := '1.1.1'
    version2 := '1.1.2'

    if version.eq(version1, version2) {
        println("versions are equal")
    }
    else {
        println("version are not equal")
    }

    // version.eq(version1, version2) == false
    // version.ne(version1, version2) == true
    // version.gt(version1, version2) == false
    // version.ge(version1, version2) == false
    // version.lt(version1, version2) == true
    // version.le(version1, version2) == true

    version_details := version.parse('1.1.1-beta3')
    println(version_details)

    /*

    output:

    version.Version{
        value: '1.1.1'
        major: 1
        minor: 1
        patch: 1
        suffix: 2
        suffixpatch: 3
    }

    */
}
```

## License

MIT