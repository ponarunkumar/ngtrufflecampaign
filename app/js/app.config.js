routing.$inject = ['$locationProvider'];

export default function routing($locationProvider) {
	$locationProvider.html5Mode({
		enabled: true,
		requireBase: false
	});
}