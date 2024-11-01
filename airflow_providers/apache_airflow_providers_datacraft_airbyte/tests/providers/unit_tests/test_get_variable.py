import requests


def test_run():
    assert 1 != 0


def test_healcheck():
    url = "http://localhost:8081/api/v1/health"
    result = requests.get(url)

    assert result.status_code == 200


def test_get_variables():
    url = "http://localhost:8081/api/v1/variables"
    result = requests.get(
        url,
        auth=("airflow", "airflow")
    )

    variables = result.json()["variables"]
    variables_names = []
    for variable in variables:
        for key, value in variable.items():
            variables_names.append(value)

    assert "from_moscow" not in variables_names
    assert "from_datacraft" in variables_names
