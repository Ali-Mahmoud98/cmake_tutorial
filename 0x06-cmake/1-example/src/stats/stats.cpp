#include "stats.h"
#include "supermath.h"

namespace stats {
    double mean(int a, int b) {
        return supermath::add(a, b) / 2.0;
    }

    double difference(int a, int b) {
        return supermath::subtract(a, b);
    }
}
