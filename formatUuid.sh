#!/usr/bin/env node
const toFormat = process.argv[2]
if (!toFormat) {
    console.warn('Usage: format-uuid guid-to-format')
    process.exit(1)
}
const lowerNoDashes = toFormat.toLowerCase().replace(/-/gi, '')
const upperNoDashes = toFormat.toUpperCase().replace(/-/gi, '')
const lowerDashes = addDashes(lowerNoDashes)
const upperDashes = addDashes(upperNoDashes)
console.log(lowerNoDashes)
console.log(upperNoDashes)
console.log(lowerDashes)
console.log(upperDashes)
// Input, something like:  c4e97a4f43794734ab6e1ba386c16eff
// Output, something like: c4e97a4f-4379-4734-ab6e-1ba386c16eff
function addDashes(v) {
    return v.slice(0, 8) + '-'
        + v.slice(8, 12) + '-'
        + v.slice(12, 16) + '-'
        + v.slice(16, 20) + '-'
        + v.slice(20)
}

